resource "aws_ecs_cluster" "this" {
  name = "replybot-cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_task_definition" "this" {
  family = "replybot-task"
  container_definitions = jsonencode(

    [
      {
        name      = "replybot-task",
        image     = "${aws_ecr_repository.this.repository_url}",
        essential = true,
        memory    = 128,
        cpu       = 256,
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
}

resource "aws_ecs_service" "this" {
  name            = "replybot-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
}
