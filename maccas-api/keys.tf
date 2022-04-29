resource "azurerm_api_management_named_value" "maccas-lambda-api-key" {
  name                = "maccas-lambda-api-key"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "MaccasLambdaApiKey"
  secret              = true
  value               = aws_api_gateway_api_key.api-key.value
}

resource "azurerm_api_management_subscription" "maccas-bot-subscription" {
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
  product_id          = azurerm_api_management_product.maccas-bot.id
  display_name        = "Maccas Bot"
  state               = "active"
}
