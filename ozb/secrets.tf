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

module "axiom-token" {
  source      = "../module/keyvault-value-output"
  secret_name = "ozb-axiom-token"
}
