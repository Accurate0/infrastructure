data "azurerm_api_management_product" "maccas-apim" {
  product_id          = "MaccasApiKey"
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
}

resource "azurerm_api_management_product_api" "log-api-2" {
  api_name            = azurerm_api_management_api.log-v1.name
  product_id          = data.azurerm_api_management_product.maccas-apim.product_id
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
}
