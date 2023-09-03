data "aws_ecs_cluster" "this" {
  cluster_name = "default-cluster"
}

resource "aws_ecs_task_definition" "this" {
  family       = "shared-applications-task"
  network_mode = "bridge"
  container_definitions = jsonencode(
    [
      {
        name      = "nginx",
        image     = "${aws_ecr_repository.nginx.repository_url}",
        essential = true,
        memory    = 128,
        cpu       = 128,
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
        links     = ["uptime:uptime"],
        dependsOn = [{ containerName = "uptime", condition = "START" }]
      },
      {
        name      = "uptime",
        image     = "louislam/uptime-kuma:1",
        essential = true,
        memory    = 128,
        cpu       = 128,
        logConfiguration = {
          logDriver = "awslogs",
          options = {
            awslogs-group         = "${aws_cloudwatch_log_group.uptime.name}",
            awslogs-region        = "ap-southeast-2",
            awslogs-stream-prefix = "ecs"
          }
        },
        mountPoints = [
          {
            containerPath = "/app/data",
            sourceVolume  = "Uptime-Data"
          }
        ],
      },
    ]
  )

  volume {
    name = "Uptime-Data"
    efs_volume_configuration {
      file_system_id     = data.aws_efs_file_system.data.id
      transit_encryption = "ENABLED"
      authorization_config {
        access_point_id = aws_efs_access_point.uptime-data.id
        iam             = "ENABLED"
      }
    }
  }

  requires_compatibilities = ["EC2"]
  execution_role_arn       = aws_iam_role.ecs-task-execution-role.arn
  task_role_arn            = aws_iam_role.ecs-container-iam-role.arn
}

resource "aws_ecs_service" "this" {
  name            = "shared-applications-service"
  cluster         = data.aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
}
