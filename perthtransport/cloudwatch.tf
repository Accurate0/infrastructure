resource "aws_cloudwatch_log_group" "perthtransport-log" {
  name              = "/aws/ecs/perthtransport"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_metric_filter" "perthtransport-error" {
  name           = "perthtransport-error-counts"
  pattern        = "{ $.level = \"ERROR\" }"
  log_group_name = aws_cloudwatch_log_group.perthtransport-log.name

  metric_transformation {
    name      = "ErrorCount"
    namespace = "PerthTransport"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "perthtransport-error-alarm" {
  alarm_name          = "perthtransport-error-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  datapoints_to_alarm = 1
  metric_name         = "ErrorCount"
  namespace           = "PerthTransport"
  period              = 30
  statistic           = "Sum"
  threshold           = 10
  alarm_description   = "Error counts in Perth Transport API"
  treat_missing_data  = "notBreaching"
  alarm_actions       = [aws_sns_topic.alert-notification.arn]
}
