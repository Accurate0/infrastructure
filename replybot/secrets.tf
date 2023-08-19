resource "aws_secretsmanager_secret" "bot-secret-openai-key" {
  name = "Replybot-OpenAiKey"
}

resource "aws_secretsmanager_secret_version" "bot-secret-openai-key" {
  secret_id     = aws_secretsmanager_secret.bot-secret-openai-key.id
  secret_string = "undefined"

  lifecycle {
    ignore_changes = [secret_string]
  }
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
