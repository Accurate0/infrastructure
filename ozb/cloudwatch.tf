resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/ecs/ozb"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "trigger-log" {
  name              = "/aws/lambda/${aws_lambda_function.trigger.function_name}"
  retention_in_days = 14
}
