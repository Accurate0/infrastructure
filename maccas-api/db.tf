resource "aws_dynamodb_table" "maccas-api-db" {
  name           = "MaccasApiDb"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "account_name"

  attribute {
    name = "account_name"
    type = "S"
  }
}

resource "aws_dynamodb_table" "maccas-api-cache-db" {
  name           = "MaccasApiCache"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "account_name"

  attribute {
    name = "account_name"
    type = "S"
  }
}
