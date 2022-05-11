resource "azurerm_api_management_product" "maccas-bot" {
  product_id            = "MaccasBot"
  api_management_name   = data.azurerm_api_management.general-apim.name
  resource_group_name   = data.azurerm_api_management.general-apim.resource_group_name
  display_name          = "Maccas Bot"
  subscription_required = true
  published             = true
}

resource "azurerm_api_management_product_api" "maccas-api" {
  api_name            = azurerm_api_management_api.maccas-v1.name
  product_id          = azurerm_api_management_product.maccas-bot.product_id
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
}