resource "aws_secretsmanager_secret" "bot-secret-apim-api-key" {
  name = "Replybot-ApimApiKey"
}

resource "aws_secretsmanager_secret_version" "bot-secret-apim-bot-key" {
  secret_id     = aws_secretsmanager_secret.bot-secret-apim-api-key.id
  secret_string = azurerm_api_management_subscription.internal-policy-apim-subscription.primary_key
}

resource "aws_secretsmanager_secret" "bot-secret-discord-token" {
  name = "Replybot-DiscordAuthToken"
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

data "aws_secretsmanager_secret" "redis-connection-string" {
  name = "Shared-RedisConnectionString"
}
