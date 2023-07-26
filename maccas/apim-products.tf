data "azurerm_resource_group" "general-api-group" {
  name = "general-api-group"
}

data "azurerm_api_management" "general-apim" {
  name                = "general-apim"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

resource "azurerm_api_management_product" "maccas-policy-apim" {
  product_id            = "MaccasApiKey"
  api_management_name   = data.azurerm_api_management.general-apim.name
  resource_group_name   = data.azurerm_api_management.general-apim.resource_group_name
  display_name          = "Maccas API Key (Internal)"
  subscription_required = true
  published             = true
}

module "product-apis" {
  source     = "../module/apim-product-apis"
  api_list   = ["Places-API-v1", "Graph-API-v1"]
  product_id = azurerm_api_management_product.maccas-policy-apim.product_id
}

resource "azurerm_api_management_subscription" "maccas-policy-apim-subscription" {
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
  product_id          = azurerm_api_management_product.maccas-policy-apim.id
  display_name        = "Maccas API Key (Internal)"
  state               = "active"
  allow_tracing       = false
}
