resource "aws_ecs_cluster" "this" {
  name = "replybot-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = "replybot-task" # Naming our first task
  container_definitions    = <<EOF
  [
    {
      "name": "replybot-task",
      "image": "${aws_ecr_repository.this.repository_url}",
      "essential": true,
      "memory": 512,
      "cpu": 256
    }
  ]
  EOF
  requires_compatibilities = ["EC2"]
  execution_role_arn       = aws_iam_role.ecs-task-execution-role.arn
}

resource "aws_ecs_service" "this" {
  name            = "replybot-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
}
