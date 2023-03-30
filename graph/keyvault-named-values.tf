module "b2c-client-secret" {
  source       = "../module/keyvault-named-value"
  named_value  = "B2CClientSecret"
  secret_name  = "b2c-client-secret"
  secret_value = azuread_application_password.this.value
}
