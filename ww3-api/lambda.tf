resource "aws_iam_role" "iam_for_ww3_api" {
  name = "iam_for_ww3_api"

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

  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
}

data "archive_file" "dummy" {
  type        = "zip"
  output_path = "${path.module}/lambda_function_payload.zip"

  source {
    content  = "dummy"
    filename = "dummy.txt"
  }
}

resource "aws_lambda_function" "ww3-api" {
  function_name = "WW3Api"
  handler       = "main"
  role          = aws_iam_role.iam_for_ww3_api.arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 60
  memory_size   = 256

  runtime = "go1.x"
}
