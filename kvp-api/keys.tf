resource "azurerm_api_management_named_value" "kvp-lambda-api-key" {
  name                = "kvp-lambda-api-key"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "KvpLambdaApiKey"
  secret              = true
  value               = aws_api_gateway_api_key.api-key.value
}
