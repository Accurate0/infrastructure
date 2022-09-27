resource "azurerm_api_management_named_value" "upbank-shame-api-key" {
  name                = "upbank-shame-api-key"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "UpBankShameApiKey"
  secret              = true
  value               = aws_api_gateway_api_key.api-key.value
}
