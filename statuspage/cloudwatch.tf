resource "aws_cloudwatch_log_group" "healthcheck-log" {
  name              = "/aws/lambda/${aws_lambda_function.healthcheck.function_name}"
  retention_in_days = 14
}
