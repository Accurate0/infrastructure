resource "aws_cloudwatch_log_group" "replybot-log" {
  name              = "/aws/ecs/replybot"
  retention_in_days = 14
}
