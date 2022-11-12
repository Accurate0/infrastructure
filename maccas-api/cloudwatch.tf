resource "aws_cloudwatch_log_group" "api-log" {
  name              = "/aws/lambda/${aws_lambda_function.api.function_name}"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "api-dev-log" {
  name              = "/aws/lambda/${aws_lambda_function.api-dev.function_name}"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "cleanup-log" {
  name              = "/aws/lambda/${aws_lambda_function.cleanup.function_name}"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "images-log" {
  name              = "/aws/lambda/${aws_lambda_function.images.function_name}"
  retention_in_days = 14
}
