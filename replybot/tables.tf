resource "aws_dynamodb_table" "replybot-interaction" {
  name           = "ReplybotInteraction"
  billing_mode   = "PROVISIONED"
  read_capacity  = 3
  write_capacity = 3
  hash_key       = "hash"
  attribute {
    name = "hash"
    type = "S"
  }

  attribute {
    name = "discord_id"
    type = "S"
  }

  global_secondary_index {
    name            = "DiscordIdIndex"
    hash_key        = "discord_id"
    read_capacity   = 5
    write_capacity  = 1
    projection_type = "ALL"
  }
}
