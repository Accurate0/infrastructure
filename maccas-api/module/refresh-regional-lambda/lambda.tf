data "archive_file" "dummy" {
  type        = "zip"
  output_path = "${path.module}/lambda_function_payload.zip"

  source {
    content  = "dummy"
    filename = "dummy.txt"
  }
}

resource "aws_lambda_function" "api" {
  function_name = "MaccasApi-refresh-v2"
  handler       = "bootstrap"
  role          = var.role_arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 120
  memory_size   = 256
  runtime       = "provided.al2"
}

resource "aws_cloudwatch_log_group" "api-refresh-log" {
  name              = "/aws/lambda/${aws_lambda_function.api.function_name}"
  retention_in_days = 14
}
