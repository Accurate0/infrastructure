resource "aws_dynamodb_table" "replybot-interaction" {
  name           = "ReplybotInteraction"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "hash"
  attribute {
    name = "hash"
    type = "S"
  }
}
