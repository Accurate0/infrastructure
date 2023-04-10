resource "aws_secretsmanager_secret" "bot-secret-discord-token" {
  name = "Ozb-DiscordAuthToken"
}

resource "aws_secretsmanager_secret_version" "bot-secret-discord-token" {
  secret_id     = aws_secretsmanager_secret.bot-secret-discord-token.id
  secret_string = "REPLACED_IN_PORTAL"

  lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
}

resource "aws_secretsmanager_secret" "bot-secret-discord-token-dev" {
  name = "Ozb-DiscordAuthToken-dev"
}

resource "aws_secretsmanager_secret_version" "bot-secret-discord-token-dev" {
  secret_id     = aws_secretsmanager_secret.bot-secret-discord-token-dev.id
  secret_string = "REPLACED_IN_PORTAL"

  lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
}

resource "aws_secretsmanager_secret" "mongodb-connection-string" {
  name = "Ozb-MongoDbConnectionString"
}

resource "aws_secretsmanager_secret_version" "mongodb-connection-string" {
  secret_id     = aws_secretsmanager_secret.mongodb-connection-string.id
  secret_string = "mongodb+srv://${mongodbatlas_database_user.ozb-user.username}:${random_password.ozb-user-password.result}@${trimprefix(mongodbatlas_cluster.this.srv_address, "mongodb+srv://")}/${var.database-name}"
}

resource "random_password" "ozb-user-password" {
  length  = 50
  special = false
}

resource "random_password" "ozb-user-password-dev" {
  length  = 50
  special = false
}

resource "aws_secretsmanager_secret" "mongodb-connection-string-dev" {
  name = "Ozb-MongoDbConnectionString-dev"
}

resource "aws_secretsmanager_secret_version" "mongodb-connection-string-dev" {
  secret_id     = aws_secretsmanager_secret.mongodb-connection-string-dev.id
  secret_string = "mongodb+srv://${mongodbatlas_database_user.ozb-user-dev.username}:${random_password.ozb-user-password-dev.result}@${trimprefix(mongodbatlas_cluster.this.srv_address, "mongodb+srv://")}/${var.dev-database-name}"
}

resource "aws_secretsmanager_secret" "redis-connection-string" {
  name = "Ozb-RedisConnectionString"
}

resource "aws_secretsmanager_secret_version" "redis-connection-string" {
  secret_id     = aws_secretsmanager_secret.redis-connection-string.id
  secret_string = module.redis.connection_string
}
