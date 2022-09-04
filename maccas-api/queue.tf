resource "aws_sqs_queue" "maccas-cleanup-queue" {
  name                      = "maccas-cleanup-queue"
  delay_seconds             = 900
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  sqs_managed_sse_enabled   = true
}

resource "aws_lambda_event_source_mapping" "maccas-cleanup-event-mapping" {
  event_source_arn = aws_sqs_queue.maccas-cleanup-queue.arn
  enabled          = true
  function_name    = aws_lambda_function.cleanup.function_name
  batch_size       = 1
}
