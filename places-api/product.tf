data "azurerm_api_management_product" "maccas-bot" {
  product_id          = "MaccasBot"
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
}

data "azurerm_api_management_product" "maccas-apim" {
  product_id          = "MaccasAPIMPolicy"
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
}

resource "azurerm_api_management_product_api" "places-api" {
  api_name            = azurerm_api_management_api.places-v1.name
  product_id          = data.azurerm_api_management_product.maccas-bot.product_id
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
}

resource "azurerm_api_management_product_api" "places-api-2" {
  api_name            = azurerm_api_management_api.places-v1.name
  product_id          = data.azurerm_api_management_product.maccas-apim.product_id
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
}
