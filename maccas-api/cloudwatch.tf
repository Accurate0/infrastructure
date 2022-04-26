resource "aws_cloudwatch_log_group" "api-log" {
  name              = "/aws/lambda/${aws_lambda_function.api.function_name}"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "api-deals-log" {
  name              = "/aws/lambda/${aws_lambda_function.api-deals.function_name}"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "api-refresh-log" {
  name              = "/aws/lambda/${aws_lambda_function.api-refresh.function_name}"
  retention_in_days = 14
}
