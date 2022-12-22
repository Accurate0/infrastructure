resource "aws_cloudwatch_log_group" "replybot-log" {
  name              = "/ecs/replybot"
  retention_in_days = 14
}
