resource "aws_secretsmanager_secret" "api-secret-places-api-key" {
  name = "MaccasApi-PlacesApiKey"
}

resource "aws_secretsmanager_secret_version" "api-secret-places-api-key" {
  secret_id     = aws_secretsmanager_secret.api-secret-places-api-key.id
  secret_string = google_apikeys_key.this.key_string
}

resource "aws_secretsmanager_secret" "api-secret-ad-client" {
  name = "MaccasApi-AdClientSecret"
}

resource "aws_secretsmanager_secret_version" "api-secret-ad-client" {
  secret_id     = aws_secretsmanager_secret.api-secret-ad-client.id
  secret_string = azuread_application_password.this.value
}
