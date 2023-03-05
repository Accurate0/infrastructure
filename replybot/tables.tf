resource "aws_dynamodb_table" "replybot-interaction" {
  name           = "ReplybotInteraction"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "hash"
  attribute {
    name = "hash"
    type = "S"
  }
}
