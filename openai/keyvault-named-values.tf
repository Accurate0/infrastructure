module "openai-api-key" {
  source      = "../module/keyvault-named-value-external"
  named_value = "OpenAiApiKey"
  secret_name = "openai-api-key"
}
