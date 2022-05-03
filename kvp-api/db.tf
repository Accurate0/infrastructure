resource "aws_dynamodb_table" "kvp-api-db" {
  name           = "KvpApiDb"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "key"

  attribute {
    name = "key"
    type = "S"
  }
}
