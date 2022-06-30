resource "aws_dynamodb_table" "maccas-api-cache-db" {
  name           = "MaccasApiCache-v2"
  billing_mode   = "PROVISIONED"
  read_capacity  = 6
  write_capacity = 3
  hash_key       = "deal_uuid"

  ttl {
    enabled        = true
    attribute_name = "ttl"
  }

  attribute {
    name = "deal_uuid"
    type = "S"
  }
}

resource "aws_dynamodb_table" "maccas-api-user-config-db" {
  name           = "MaccasApiUserConfig-v2"
  billing_mode   = "PROVISIONED"
  read_capacity  = 3
  write_capacity = 1
  hash_key       = "user_id"

  attribute {
    name = "user_id"
    type = "S"
  }
}

data "aws_dynamodb_table" "maccas-api-db-v1" {
  name = "MaccasApiDb"
}

data "aws_dynamodb_table" "maccas-api-cache-db-v1" {
  name = "MaccasApiCache"
}

data "aws_dynamodb_table" "maccas-api-offer-id-db-v1" {
  name = "MaccasApiOfferId"
}
