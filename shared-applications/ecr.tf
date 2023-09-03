resource "aws_ecr_repository" "nginx" {
  name = "nginx"

  image_scanning_configuration {
    scan_on_push = true
  }
}
