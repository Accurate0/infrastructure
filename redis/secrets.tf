resource "random_password" "redis-password" {
  length  = 50
  special = false
}

module "redis-password" {
  source       = "../module/keyvault-value"
  secret_name  = "redis-cluster-password"
  secret_value = random_password.redis-password.result
}

resource "aws_secretsmanager_secret" "redis-connection-string" {
  name = "Shared-RedisConnectionString"
}

resource "aws_secretsmanager_secret_version" "redis-connection-string" {
  secret_id     = aws_secretsmanager_secret.redis-connection-string.id
  secret_string = "REPLACED"

  lifecycle {
    ignore_changes = [secret_string]
  }
}
