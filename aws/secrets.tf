resource "aws_secretsmanager_secret" "redis-connection-string" {
  name = "Shared-RedisConnectionString"
}

resource "aws_secretsmanager_secret_version" "redis-connection-string" {
  secret_id     = aws_secretsmanager_secret.redis-connection-string.id
  secret_string = module.redis.connection_string
}
