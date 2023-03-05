resource "aws_ecs_cluster" "this" {
  name = "replybot-cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_task_definition" "this" {
  family       = "replybot-task"
  network_mode = "host"
  container_definitions = jsonencode(
    [
      {
        name      = "replybot-task",
        image     = "${aws_ecr_repository.this.repository_url}",
        essential = true,
        memory    = 128,
        cpu       = 128,
        logConfiguration = {
          logDriver = "awslogs",
          options = {
            awslogs-group         = "${aws_cloudwatch_log_group.replybot-log.name}",
            awslogs-region        = "ap-southeast-2",
            awslogs-stream-prefix = "ecs"
          }
        }
      }
    ]
  )
  requires_compatibilities = ["EC2"]
  execution_role_arn       = aws_iam_role.ecs-task-execution-role.arn
  task_role_arn            = aws_iam_role.ecs-container-iam-role.arn
}


resource "aws_ecs_task_definition" "redis-cache-task" {
  family       = "replybot-cache"
  network_mode = "host"
  container_definitions = jsonencode(
    [
      {
        name      = "replybot-cache",
        image     = "redis:alpine",
        essential = true,
        memory    = 128,
        cpu       = 128,
        logConfiguration = {
          logDriver = "awslogs",
          options = {
            awslogs-group         = "${aws_cloudwatch_log_group.replybot-log.name}",
            awslogs-region        = "ap-southeast-2",
            awslogs-stream-prefix = "ecs"
          }
        }
      },
    ]
  )
  requires_compatibilities = ["EC2"]
  execution_role_arn       = aws_iam_role.ecs-task-execution-role.arn
}


resource "aws_ecs_service" "this" {
  name            = "replybot-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
}

resource "aws_ecs_service" "redis-cache-service" {
  name            = "replybot-cache"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.redis-cache-task.arn
  desired_count   = 1
}
