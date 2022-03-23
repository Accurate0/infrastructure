resource "aws_iam_role" "iam" {
  name = "iam_for_${var.api_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

data "archive_file" "dummy" {
  type        = "zip"
  output_path = "${path.module}/lambda_function_payload.zip"

  source {
    content  = "dummy"
    filename = "dummy.txt"
  }
}

resource "aws_lambda_function" "api" {
  function_name = var.api_name
  handler       = var.api_handler
  role          = aws_iam_role.iam.arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 15
  memory_size   = 128
  runtime       = var.api_runtime
}
