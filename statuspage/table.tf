resource "aws_dynamodb_table" "statuspage-healthcheck" {
  name           = "statuspage-healthcheck"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}
