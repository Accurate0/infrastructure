resource "aws_ecs_cluster" "this" {
  name = "default-cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}
