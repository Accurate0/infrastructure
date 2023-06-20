resource "aws_cloudwatch_log_group" "perthtransport-log" {
  name              = "/aws/ecs/perthtransport"
  retention_in_days = 14
}
