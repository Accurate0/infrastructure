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
resource "aws_dynamodb_table" "maccas-api-db" {
  name           = "MaccasApiDb"
  billing_mode   = "PROVISIONED"
  read_capacity  = 3
  write_capacity = 3
  hash_key       = "account_name"

  attribute {
    name = "account_name"
    type = "S"
  }
}

resource "aws_dynamodb_table" "maccas-api-cache-db-v1" {
  name           = "MaccasApiCache"
  billing_mode   = "PROVISIONED"
  read_capacity  = 6
  write_capacity = 3
  hash_key       = "account_name"

  attribute {
    name = "account_name"
    type = "S"
  }
}

resource "aws_dynamodb_table" "maccas-api-offer-id-db" {
  name           = "MaccasApiOfferId"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "offer_id"
  ttl {
    enabled        = true
    attribute_name = "ttl"
  }
  attribute {
    name = "offer_id"
    type = "S"
  }
}

resource "aws_dynamodb_table" "maccas-api-point-db" {
  name           = "MaccasApiPointDb"
  billing_mode   = "PROVISIONED"
  read_capacity  = 4
  write_capacity = 2
  hash_key       = "account_hash"
  attribute {
    name = "account_hash"
    type = "S"
  }
}
