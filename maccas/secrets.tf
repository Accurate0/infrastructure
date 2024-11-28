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

module "perth-static-ip" {
  source      = "../module/keyvault-value-output"
  secret_name = "perth-static-ip"
}

module "coolify-api-readonly-secret" {
  source      = "../module/keyvault-value-output"
  secret_name = "coolify-api-deploy-secret"
}

module "coolify-api-webhook" {
  source      = "../module/keyvault-value-output"
  secret_name = "coolify-api-maccas-webhook-url"
}

module "tailscale-client-id" {
  source      = "../module/keyvault-value-output"
  secret_name = "tailscale-client-id"
}

module "tailscale-client-secret" {
  source      = "../module/keyvault-value-output"
  secret_name = "tailscale-client-secret"
}
