resource "azurerm_api_management_subscription" "maccas-subscription" {
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
  api_id              = azurerm_api_management_api.maccas-v1.id
  display_name        = "Maccas API"
  state               = "active"
}

resource "azurerm_api_management_named_value" "maccas-lambda-api-key" {
  name                = "maccas-lambda-api-key"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "MaccasLambdaApiKey"
  secret              = true
  value               = aws_api_gateway_api_key.api-key.value
}
