resource "aws_cloudwatch_log_group" "nginx" {
  name              = "/aws/ecs/nginx"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "uptime" {
  name              = "/aws/ecs/uptime"
  retention_in_days = 14
}


resource "aws_cloudwatch_log_group" "uptime-v2" {
  name              = "/aws/ecs/uptime-v2"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "uptime-postgres" {
  name              = "/aws/ecs/uptime-postgres"
  retention_in_days = 14
}
