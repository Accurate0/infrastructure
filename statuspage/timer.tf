resource "aws_cloudwatch_event_rule" "trigger-interval" {
  name                = "healthcheck-trigger-interval"
  schedule_expression = "cron(0/5 * * * ? *)"
}

resource "aws_lambda_permission" "cloudwatch-call-healthcheck-service" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.healthcheck.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.trigger-interval.arn
}

resource "aws_cloudwatch_event_target" "healthcheck-trigger-invoke-target" {
  rule = aws_cloudwatch_event_rule.trigger-interval.name
  arn  = aws_lambda_function.healthcheck.arn
}
