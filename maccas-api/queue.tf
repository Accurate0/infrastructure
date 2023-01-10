resource "aws_sqs_queue" "maccas-cleanup-queue" {
  name                      = "maccas-cleanup-queue"
  delay_seconds             = 900
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  sqs_managed_sse_enabled   = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.maccas-dlq.arn
    maxReceiveCount     = 2
  })
}

resource "aws_sqs_queue" "maccas-images-queue" {
  name                      = "maccas-images-queue"
  delay_seconds             = 0
  max_message_size          = 20480
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  sqs_managed_sse_enabled   = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.maccas-dlq.arn
    maxReceiveCount     = 2
  })
}

resource "aws_sqs_queue" "maccas-refresh-failure-queue" {
  name                      = "maccas-refresh-failure-queue"
  delay_seconds             = 15
  max_message_size          = 20480
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  sqs_managed_sse_enabled   = true
  # should be >= function timeout
  visibility_timeout_seconds = 120

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.maccas-dlq.arn
    maxReceiveCount     = 2
  })
}


resource "aws_sqs_queue" "maccas-dlq" {
  name = "maccas-dlq"
}

resource "aws_lambda_event_source_mapping" "maccas-cleanup-event-mapping" {
  event_source_arn = aws_sqs_queue.maccas-cleanup-queue.arn
  enabled          = true
  function_name    = aws_lambda_function.cleanup.function_name
  batch_size       = 1
}

resource "aws_lambda_event_source_mapping" "maccas-images-event-mapping" {
  event_source_arn = aws_sqs_queue.maccas-images-queue.arn
  enabled          = true
  function_name    = aws_lambda_function.images.function_name
  batch_size       = 1
}

resource "aws_lambda_event_source_mapping" "maccas-refresh-failure-event-mapping" {
  event_source_arn = aws_sqs_queue.maccas-refresh-failure-queue.arn
  enabled          = true
  function_name    = aws_lambda_function.refresh-failure.function_name
  batch_size       = 10
}
