data "aws_ecs_cluster" "this" {
  cluster_name = "default-cluster"
}

resource "aws_ecs_task_definition" "this" {
  family       = "shared-applications-task"
  network_mode = "bridge"
  container_definitions = jsonencode(
    [
      {
        name              = "nginx",
        image             = "${aws_ecr_repository.nginx.repository_url}",
        essential         = true,
        memoryReservation = 128,
        portMappings = [{
          hostPort      = 80
          containerPort = 80
          protocol      = "tcp"
        }]
        linuxParameters = {
          capabilities = {
            add = ["SETUID"]
          },
        },
        logConfiguration = {
          logDriver = "awslogs",
          options = {
            awslogs-group         = "${aws_cloudwatch_log_group.nginx.name}",
            awslogs-region        = "ap-southeast-2",
            awslogs-stream-prefix = "ecs"
          }
        }
        links     = ["uptime-v2:uptime"]
        dependsOn = [{ containerName = "uptime-v2", condition = "START" }]
      },
      {
        name              = "uptime-v2",
        image             = "adamboutcher/statping-ng:latest",
        essential         = true,
        memoryReservation = 128,
        logConfiguration = {
          logDriver = "awslogs",
          options = {
            awslogs-group         = "${aws_cloudwatch_log_group.uptime-v2.name}",
            awslogs-region        = "ap-southeast-2",
            awslogs-stream-prefix = "ecs"
          }
        },
        environment = [
          { name = "DB_CONN", value = "postgres" },
          { name = "DB_HOST", value = "uptime-postgres" },
          { name = "DB_USER", value = "postgres" },
          { name = "DB_PASS", value = "doesntmatterwhatitis" },
          { name = "DB_DATABASE", value = "uptime" },
          { name = "POSTGRES_SSLMODE", value = "disable" }
        ],
        links     = ["uptime-postgres:uptime-postgres"],
        dependsOn = [{ containerName = "uptime-postgres", condition = "START" }]
      },
      {
        name              = "uptime-postgres",
        image             = "postgres:15",
        memoryReservation = 128,
        environment = [
          { name = "POSTGRES_PASSWORD", value = "doesntmatterwhatitis" },
          { name = "POSTGRES_DB", value = "uptime" },
          { name = "PGDATA", value = "/var/lib/postgresql/data/pgdata" }
        ],
        mountPoints = [{ containerPath = "/var/lib/postgresql/data/pgdata", sourceVolume = "Uptime-V2-Data" }],
        logConfiguration = {
          logDriver = "awslogs",
          options = {
            awslogs-group         = "${aws_cloudwatch_log_group.uptime-postgres.name}",
            awslogs-region        = "ap-southeast-2",
            awslogs-stream-prefix = "ecs"
          }
        },
      }
    ]
  )

  volume {
    name = "Uptime-V2-Data"
    efs_volume_configuration {
      file_system_id     = data.aws_efs_file_system.data.id
      transit_encryption = "ENABLED"
      authorization_config {
        access_point_id = aws_efs_access_point.uptime-data-v2.id
        iam             = "ENABLED"
      }
    }
  }

  requires_compatibilities = ["EC2"]
  execution_role_arn       = aws_iam_role.ecs-task-execution-role.arn
  task_role_arn            = aws_iam_role.ecs-container-iam-role.arn
}

resource "aws_ecs_service" "this" {
  name                               = "shared-applications-service"
  cluster                            = data.aws_ecs_cluster.this.id
  task_definition                    = aws_ecs_task_definition.this.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100
}
