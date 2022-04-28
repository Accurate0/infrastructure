resource "aws_dynamodb_table" "maccas-api-db" {
  name           = "MaccasApiDb"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "account_name"

  attribute {
    name = "account_name"
    type = "S"
  }
}

resource "aws_dynamodb_table" "maccas-api-cache-db" {
  name           = "MaccasApiCache"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "account_name"

  attribute {
    name = "account_name"
    type = "S"
  }
}

resource "aws_dynamodb_table" "maccas-api-offer-id-db" {
  name           = "MaccasApiOfferId"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
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
