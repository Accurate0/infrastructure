resource "aws_ecs_cluster" "this" {
  name = "default-cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_cluster" "oracle" {
  name = "oracle-cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}
