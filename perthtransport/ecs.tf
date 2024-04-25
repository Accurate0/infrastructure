data "aws_ecs_cluster" "this" {
  cluster_name = "oracle-cluster"
}

resource "aws_ecs_task_definition" "this" {
  family       = "perthtransport-task"
  network_mode = "bridge"
  container_definitions = jsonencode(
    [
      {
        name              = "perthtransport-api",
        image             = "${aws_ecr_repository.perthtransport-api.repository_url}",
        essential         = true,
        memoryReservation = 128,
        portMappings = [{
          hostPort      = 80
          containerPort = 8000
          protocol      = "tcp"
        }]
        logConfiguration = {
          logDriver = "awslogs",
          options = {
            awslogs-group         = "${aws_cloudwatch_log_group.perthtransport-log.name}",
            awslogs-region        = "ap-southeast-2",
            awslogs-stream-prefix = "ecs"
          }
        },
        links = ["perthtransport-redis:perthtransport-redis", "perthtransport-worker:worker"],
        environment = [
          {
            name  = "PTA_REALTIME_API_KEY"
            value = module.realtime-api-key.secret_value
          },
          {
            name  = "PTA_REFERENCE_DATA_API_KEY"
            value = module.reference-data-api-key.secret_value
          },
          {
            name  = "PTA_REDIS_CONNECTION_STRING"
            value = "redis://perthtransport-redis"
          },
          {
            name  = "PTA_WORKER_API_BASE"
            value = "http://worker:8000/v1"
          }
        ]
      },

      {
        name              = "perthtransport-worker",
        image             = "${aws_ecr_repository.perthtransport-worker.repository_url}",
        essential         = true,
        memoryReservation = 128,
        logConfiguration = {
          logDriver = "awslogs",
          options = {
            awslogs-group         = "${aws_cloudwatch_log_group.perthtransport-log.name}",
            awslogs-region        = "ap-southeast-2",
            awslogs-stream-prefix = "ecs"
          }
        },
        links = ["perthtransport-redis:perthtransport-redis"],
        environment = [
          {
            name  = "PTA_REALTIME_API_KEY"
            value = module.realtime-api-key.secret_value
          },
          {
            name  = "PTA_REFERENCE_DATA_API_KEY"
            value = module.reference-data-api-key.secret_value
          },
          {
            name  = "PTA_REDIS_CONNECTION_STRING"
            value = "redis://perthtransport-redis"
          }
        ]
      },
      {
        name              = "perthtransport-redis",
        image             = "redis:alpine",
        essential         = true,
        memoryReservation = 128,
        logConfiguration = {
          logDriver = "awslogs",
          options = {
            awslogs-group         = "${aws_cloudwatch_log_group.perthtransport-log.name}",
            awslogs-region        = "ap-southeast-2",
            awslogs-stream-prefix = "ecs"
          }
        }
      }
    ]
  )

  requires_compatibilities = ["EXTERNAL"]
  execution_role_arn       = aws_iam_role.ecs-task-execution-role.arn
  task_role_arn            = aws_iam_role.ecs-container-iam-role.arn
}

resource "aws_ecs_service" "this" {
  name            = "perthtransport-service"
  cluster         = data.aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
  launch_type     = "EXTERNAL"
  # port binding?
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100
}
