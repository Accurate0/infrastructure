resource "aws_ecr_repository" "perthtransport-api" {
  name = "perthtransport-api"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "perthtransport-worker" {
  name = "perthtransport-worker"

  image_scanning_configuration {
    scan_on_push = true
  }
}
