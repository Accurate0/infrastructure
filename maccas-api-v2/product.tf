data "azurerm_api_management_product" "maccas-bot" {
  product_id          = "MaccasBot"
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
}

resource "azurerm_api_management_product_api" "maccas-api" {
  api_name            = azurerm_api_management_api.maccas-v2.name
  product_id          = data.azurerm_api_management_product.maccas-bot.product_id
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
}

resource "azurerm_api_management_subscription" "maccas-v2-subscription" {
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
  api_id              = azurerm_api_management_api.maccas-v2.id
  display_name        = "Maccas Web API (public)"
  state               = "active"
  allow_tracing       = false
}

resource "azurerm_api_management_named_value" "maccas-api-public-id" {
  name                = "maccas-api-public-id"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "MaccasApiPublicId"
  secret              = true
  value               = element(split("/", azurerm_api_management_subscription.maccas-v2-subscription.id), length(split("/", azurerm_api_management_subscription.maccas-v2-subscription.id)) - 1)
}

resource "azurerm_api_management_product" "maccas-policy-apim" {
  product_id            = "MaccasApiKey"
  api_management_name   = data.azurerm_api_management.general-apim.name
  resource_group_name   = data.azurerm_api_management.general-apim.resource_group_name
  display_name          = "Maccas API Key"
  subscription_required = true
  published             = true
}

resource "azurerm_api_management_subscription" "maccas-policy-apim-subscription" {
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
  product_id          = azurerm_api_management_product.maccas-policy-apim.id
  display_name        = "MaccasApiKey"
  state               = "active"
}
