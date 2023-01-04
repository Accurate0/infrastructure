locals {
  hours_between_refresh = 4
}

resource "aws_cloudwatch_event_rule" "refresh-interval" {
  name                = "maccas-refresh-interval"
  schedule_expression = "cron(0 */${local.hours_between_refresh} * * ? *)"
}

resource "aws_lambda_permission" "cloudwatch-call-maccas-service" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.refresh-interval.arn
}

resource "aws_cloudwatch_event_target" "maccas-refresh-invoke-target" {
  rule = aws_cloudwatch_event_rule.refresh-interval.name
  arn  = aws_lambda_function.api.arn
}
