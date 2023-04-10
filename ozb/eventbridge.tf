data "aws_cloudwatch_event_source" "mongodb" {
  name_prefix = "aws.partner/mongodb.com"
}

resource "aws_cloudwatch_event_bus" "mongodb" {
  name              = data.aws_cloudwatch_event_source.mongodb.name
  event_source_name = data.aws_cloudwatch_event_source.mongodb.name
}

resource "aws_cloudwatch_event_archive" "ozb" {
  name             = "ozb-archive"
  description      = "Archived events from ozb-mongodb"
  event_source_arn = aws_cloudwatch_event_bus.mongodb.arn
  retention_days   = 14
}

resource "aws_cloudwatch_event_rule" "mongodb" {
  name           = "ozb-mongodb"
  event_bus_name = aws_cloudwatch_event_bus.mongodb.name
  event_pattern = jsonencode({
    source = [{
      prefix = "aws.partner/mongodb.com"
    }]
  })
}

resource "aws_cloudwatch_event_target" "trigger-invoke-target" {
  rule           = aws_cloudwatch_event_rule.mongodb.name
  event_bus_name = aws_cloudwatch_event_bus.mongodb.name
  arn            = aws_lambda_function.trigger.arn
}


resource "aws_lambda_permission" "cloudwatch-call-trigger" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.trigger.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.mongodb.arn
}

resource "aws_cloudwatch_event_rule" "timed-interval" {
  name = "ozb-timed-interval"
  # 3am run in UTC
  schedule_expression = "cron(0 19 * * ? *)"
}

resource "aws_lambda_permission" "cloudwatch-call-timed" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.timed.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.timed-interval.arn
}

resource "aws_cloudwatch_event_target" "timed-invoke-target" {
  rule = aws_cloudwatch_event_rule.timed-interval.name
  arn  = aws_lambda_function.timed.arn
}

resource "aws_scheduler_schedule" "daemon-schedule" {
  name = "ozb-daemon-schedule"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "rate(3 minutes)"

  target {
    arn      = aws_lambda_function.daemon.arn
    role_arn = aws_iam_role.scheduler-execution-role.arn
    retry_policy {
      maximum_retry_attempts = 0
    }
  }
}
