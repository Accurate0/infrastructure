resource "aws_cloudwatch_log_group" "service-log" {
  name              = "/aws/lambda/${aws_lambda_function.weather-service.function_name}"
  retention_in_days = 14
}
