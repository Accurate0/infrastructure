# resource "aws_lambda_permission" "cloudwatch-call-maccas-service" {
#   statement_id  = "AllowExecutionFromCloudWatch"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.api-refresh.function_name
#   principal     = "events.amazonaws.com"
#   source_arn    = aws_cloudwatch_event_rule.refresh-every-6-hours.arn
# }

# resource "aws_cloudwatch_event_rule" "refresh-every-6-hours" {
#   name                = "MaccasRefresh6Hours"
#   schedule_expression = "rate(6 hours)"
# }

# resource "aws_cloudwatch_event_target" "maccas-refresh-invoke-target" {
#   rule = aws_cloudwatch_event_rule.refresh-every-6-hours.name
#   arn  = aws_lambda_function.api-refresh.arn
# }
