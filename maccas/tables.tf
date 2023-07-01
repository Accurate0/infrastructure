resource "aws_dynamodb_table" "maccas-api-cache-db" {
  name                        = "MaccasApiCache-v2"
  billing_mode                = "PAY_PER_REQUEST"
  hash_key                    = "deal_uuid"
  deletion_protection_enabled = true

  ttl {
    enabled        = true
    attribute_name = "ttl"
  }

  attribute {
    name = "deal_uuid"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "maccas-api-user-config-db" {
  name                        = "MaccasApiUserConfig-v2"
  billing_mode                = "PROVISIONED"
  read_capacity               = 2
  write_capacity              = 1
  hash_key                    = "user_id"
  deletion_protection_enabled = true

  attribute {
    name = "user_id"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}
resource "aws_dynamodb_table" "maccas-api-db" {
  name                        = "MaccasApiDb"
  billing_mode                = "PROVISIONED"
  read_capacity               = 3
  write_capacity              = 3
  hash_key                    = "account_name"
  deletion_protection_enabled = true

  attribute {
    name = "account_name"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "maccas-api-cache-db-v1" {
  name                        = "MaccasApiCache"
  billing_mode                = "PAY_PER_REQUEST"
  hash_key                    = "account_name"
  deletion_protection_enabled = true

  ttl {
    enabled        = true
    attribute_name = "ttl"
  }

  attribute {
    name = "account_name"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "maccas-api-offer-id-db" {
  name                        = "MaccasApiOfferId"
  billing_mode                = "PROVISIONED"
  read_capacity               = 1
  write_capacity              = 1
  hash_key                    = "offer_id"
  deletion_protection_enabled = true

  ttl {
    enabled        = true
    attribute_name = "ttl"
  }

  attribute {
    name = "offer_id"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "maccas-api-point-db" {
  name                        = "MaccasApiPointDb"
  billing_mode                = "PROVISIONED"
  read_capacity               = 2
  write_capacity              = 2
  hash_key                    = "account_hash"
  deletion_protection_enabled = true

  attribute {
    name = "account_hash"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "maccas-refresh-tracking-db" {
  name                        = "MaccasRefreshTrackingDb"
  billing_mode                = "PROVISIONED"
  read_capacity               = 1
  write_capacity              = 1
  hash_key                    = "region"
  deletion_protection_enabled = true

  attribute {
    name = "region"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "maccas-audit-db" {
  name                        = "MaccasAudit"
  billing_mode                = "PROVISIONED"
  read_capacity               = 3
  write_capacity              = 1
  hash_key                    = "operation_id"
  deletion_protection_enabled = true

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
    read_capacity   = 2
    write_capacity  = 1
    projection_type = "ALL"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "maccas-audit-data" {
  name                        = "MaccasAuditData"
  billing_mode                = "PROVISIONED"
  read_capacity               = 1
  write_capacity              = 1
  hash_key                    = "key"
  deletion_protection_enabled = true

  attribute {
    name = "key"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "maccas-user-accounts" {
  name                        = "MaccasUserAccounts"
  billing_mode                = "PROVISIONED"
  read_capacity               = 3
  write_capacity              = 3
  hash_key                    = "account_name"
  deletion_protection_enabled = true

  attribute {
    name = "account_name"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}
