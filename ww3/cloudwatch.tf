resource "aws_cloudwatch_log_group" "lambda-log" {
  name              = "/aws/lambda/WW3Api"
  retention_in_days = 14
}
