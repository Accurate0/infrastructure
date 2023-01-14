resource "aws_ecr_repository" "this" {
  name = "maccas-refresh-worker"

  image_scanning_configuration {
    scan_on_push = true
  }
}
