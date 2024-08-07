resource "aws_cloudwatch_log_group" "trigger-log" {
  name              = "/aws/lambda/${aws_lambda_function.trigger.function_name}"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "timed-log" {
  name              = "/aws/lambda/${aws_lambda_function.timed.function_name}"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "daemon-log" {
  name              = "/aws/lambda/${aws_lambda_function.daemon.function_name}"
  retention_in_days = 14
}
