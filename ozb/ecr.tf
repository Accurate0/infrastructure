resource "aws_ecr_repository" "this" {
  name = "ozb"

  image_scanning_configuration {
    scan_on_push = true
  }
}
