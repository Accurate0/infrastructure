resource "aws_dynamodb_table" "maccas-api-cache-db" {
  name           = "MaccasApiCache-v2"
  billing_mode   = "PROVISIONED"
  read_capacity  = 2
  write_capacity = 6
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
  read_capacity  = 2
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

  ttl {
    enabled        = true
    attribute_name = "ttl"
  }

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
  read_capacity  = 2
  write_capacity = 2
  hash_key       = "account_hash"
  attribute {
    name = "account_hash"
    type = "S"
  }
}

resource "aws_dynamodb_table" "maccas-refresh-tracking-db" {
  name           = "MaccasRefreshTrackingDb"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "region"
  attribute {
    name = "region"
    type = "S"
  }
}

resource "aws_dynamodb_table" "maccas-audit-db" {
  name           = "MaccasAudit"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 1
  hash_key       = "operation_id"
  attribute {
    name = "operation_id"
    type = "S"
  }

  attribute {
    name = "user_id"
    type = "S"
  }

  global_secondary_index {
    name            = "UserIdIndex"
    hash_key        = "user_id"
    read_capacity   = 5
    write_capacity  = 1
    projection_type = "ALL"
  }
}
