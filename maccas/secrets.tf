resource "aws_secretsmanager_secret" "api-secret-ad-client" {
  name = "MaccasApi-AdClientSecret"
}

resource "aws_secretsmanager_secret_version" "api-secret-ad-client" {
  secret_id     = aws_secretsmanager_secret.api-secret-ad-client.id
  secret_string = azuread_application_password.this.value
}

resource "aws_secretsmanager_secret" "api-secret-key" {
  name = "MaccasApi-SecretKey"
}

resource "random_password" "secret-key" {
  length = 100
}

resource "aws_secretsmanager_secret_version" "api-secret-key" {
  secret_id     = aws_secretsmanager_secret.api-secret-key.id
  secret_string = random_password.secret-key.result
}
