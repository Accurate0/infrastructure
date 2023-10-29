resource "aws_dynamodb_table" "maccas-api-deals" {
  name                        = "MaccasApi-Deals"
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

resource "aws_dynamodb_table" "maccas-api-userconfig" {
  name                        = "MaccasApi-UserConfig"
  billing_mode                = "PAY_PER_REQUEST"
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

resource "aws_dynamodb_table" "maccas-api-tokens" {
  name                        = "MaccasApi-Tokens"
  billing_mode                = "PAY_PER_REQUEST"
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

resource "aws_dynamodb_table" "maccas-api-accounts" {
  name                        = "MaccasApi-Accounts"
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

resource "aws_dynamodb_table" "maccas-api-offer-locked" {
  name                        = "MaccasApi-LockedOffers"
  billing_mode                = "PAY_PER_REQUEST"
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

resource "aws_dynamodb_table" "maccas-points" {
  name                        = "MaccasApi-Points"
  billing_mode                = "PAY_PER_REQUEST"
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

resource "aws_dynamodb_table" "maccas-refreshtracking" {
  name                        = "MaccasApi-RefreshTracking"
  billing_mode                = "PAY_PER_REQUEST"
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

resource "aws_dynamodb_table" "maccas-lastrefresh" {
  name                        = "MaccasApi-LastRefresh"
  billing_mode                = "PAY_PER_REQUEST"
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

resource "aws_dynamodb_table" "maccas-audit" {
  name                        = "MaccasApi-Audit"
  billing_mode                = "PAY_PER_REQUEST"
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
    projection_type = "ALL"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "maccas-useraccounts" {
  name                        = "MaccasApi-UserAccounts"
  billing_mode                = "PAY_PER_REQUEST"
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

resource "aws_dynamodb_table" "maccas-users" {
  name                        = "MaccasApi-Users"
  billing_mode                = "PAY_PER_REQUEST"
  hash_key                    = "username"
  deletion_protection_enabled = true

  attribute {
    name = "username"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "maccas-user-tokens" {
  name                        = "MaccasApi-UserTokens"
  billing_mode                = "PAY_PER_REQUEST"
  hash_key                    = "username"
  deletion_protection_enabled = true

  ttl {
    enabled        = true
    attribute_name = "ttl"
  }

  attribute {
    name = "username"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "maccas-deals-db" {
  name                        = "MaccasApi-Deals-v3"
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

  attribute {
    name = "offer_proposition_id"
    type = "S"
  }

  attribute {
    name = "account_name"
    type = "S"
  }

  global_secondary_index {
    name            = "OfferPropositionIdIndex"
    hash_key        = "offer_proposition_id"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "AccountNameIndex"
    hash_key        = "account_name"
    projection_type = "ALL"
  }

  lifecycle {
    prevent_destroy = true
  }
}
