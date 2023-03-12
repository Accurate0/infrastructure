data "aws_ecs_cluster" "this" {
  cluster_name = "default-cluster"
}

resource "aws_ecs_task_definition" "this" {
  family       = "replybot-task"
  network_mode = "bridge"
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
        },
        dependsOn = [{
          containerName : "replybot-cache",
          condition : "START"
        }],
        links = ["replybot-cache:replybot-cache"]
      },
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
  task_role_arn            = aws_iam_role.ecs-container-iam-role.arn
}

resource "aws_ecs_service" "this" {
  name            = "replybot-service"
  cluster         = data.aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
}
