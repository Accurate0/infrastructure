variable "interaction-table-user-id-index" {
  default = "DiscordIdIndex"
}

resource "aws_dynamodb_table" "replybot-interaction" {
  name                        = "ReplybotInteraction"
  billing_mode                = "PROVISIONED"
  read_capacity               = 1
  write_capacity              = 1
  hash_key                    = "hash"
  deletion_protection_enabled = true

  attribute {
    name = "hash"
    type = "S"
  }

  attribute {
    name = "discord_id"
    type = "S"
  }

  global_secondary_index {
    name            = var.interaction-table-user-id-index
    hash_key        = "discord_id"
    read_capacity   = 1
    write_capacity  = 1
    projection_type = "ALL"
  }

  lifecycle {
    prevent_destroy = true
  }
}
