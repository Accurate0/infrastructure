data "azurerm_api_management_product" "openai-apim" {
  product_id          = "ReplybotApiKey"
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
}

resource "azurerm_api_management_product_api" "openai-api" {
  api_name            = azurerm_api_management_api.openai-v1.name
  product_id          = data.azurerm_api_management_product.openai-apim.product_id
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
}
