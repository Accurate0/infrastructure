resource "aws_cloudwatch_log_group" "vpn-log" {
  name              = "/aws/ecs/vpn"
  retention_in_days = 14
}
