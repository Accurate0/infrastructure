resource "aws_dynamodb_table" "kvp-api-db" {
  name           = "KvpApiDb"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "key"

  attribute {
    name = "key"
    type = "S"
  }
}
