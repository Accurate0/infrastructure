resource "azurerm_api_management_product" "internal-policy-apim" {
  product_id            = "ReplybotApiKey"
  api_management_name   = data.azurerm_api_management.general-apim.name
  resource_group_name   = data.azurerm_api_management.general-apim.resource_group_name
  display_name          = "Replybot API Key (Internal)"
  subscription_required = true
  published             = true
}

resource "azurerm_api_management_subscription" "internal-policy-apim-subscription" {
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
  product_id          = azurerm_api_management_product.internal-policy-apim.id
  display_name        = "Replybot API Key (Internal)"
  state               = "active"
  allow_tracing       = false
}
