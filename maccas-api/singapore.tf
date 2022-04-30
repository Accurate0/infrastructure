resource "aws_lambda_function" "api-refresh-singapore" {
  provider      = aws.singapore
  function_name = "MaccasApi-refresh"
  handler       = "bootstrap"
  role          = aws_iam_role.iam.arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 60
  memory_size   = 256
  runtime       = "provided.al2"
}

resource "aws_cloudwatch_event_rule" "refresh-every-6-hours-singapore" {
  provider            = aws.singapore
  name                = "MaccasRefresh6Hours"
  schedule_expression = "rate(6 hours)"
}

resource "aws_lambda_permission" "cloudwatch-call-maccas-service-singapore" {
  provider      = aws.singapore
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api-refresh-singapore.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.refresh-every-6-hours-singapore.arn
}

resource "aws_cloudwatch_event_target" "maccas-refresh-singapore-invoke-target" {
  provider = aws.singapore
  rule     = aws_cloudwatch_event_rule.refresh-every-6-hours-singapore.name
  arn      = aws_lambda_function.api-refresh-singapore.arn
}

resource "aws_lambda_function_url" "lambda-url-singapore" {
  provider           = aws.singapore
  function_name      = aws_lambda_function.api-refresh-singapore.function_name
  authorization_type = "NONE"
}
