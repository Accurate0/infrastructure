resource "github_actions_secret" "infra-repo-key-id" {
  repository      = "infrastructure"
  secret_name     = "ARM_CLIENT_ID"
  plaintext_value = azuread_application.terraform.application_id
}

resource "github_actions_secret" "infra-repo-secret" {
  repository      = "infrastructure"
  secret_name     = "ARM_CLIENT_SECRET"
  plaintext_value = azuread_application_password.terraform-credentials.value
}
