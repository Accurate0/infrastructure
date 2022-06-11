data "azurerm_api_management_product" "maccas-bot" {
  product_id          = "MaccasBot"
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
}

resource "azurerm_api_management_product" "maccas-web-api-public" {
  product_id          = "MaccasApiPublic"
  display_name        = "Maccas Web API (public)"
  published           = true
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
}

resource "azurerm_api_management_product_api" "maccas-web-api" {
  api_name            = azurerm_api_management_api.maccas-v2.name
  product_id          = azurerm_api_management_product.maccas-web-api-public.product_id
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
}

resource "azurerm_api_management_product_policy" "maccas-web-api-public" {
  product_id          = azurerm_api_management_product.maccas-web-api-public.product_id
  api_management_name = azurerm_api_management_product.maccas-web-api-public.api_management_name
  resource_group_name = azurerm_api_management_product.maccas-web-api-public.resource_group_name

  xml_content = file("policy/public.policy.xml")
}

resource "azurerm_api_management_subscription" "maccas-v2-subscription" {
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
  product_id          = azurerm_api_management_product.maccas-web-api-public.id
  display_name        = "Maccas Web API (public)"
  state               = "active"
  allow_tracing       = false
}

resource "azurerm_api_management_product" "maccas-policy-apim" {
  product_id            = "MaccasApiKey"
  api_management_name   = data.azurerm_api_management.general-apim.name
  resource_group_name   = data.azurerm_api_management.general-apim.resource_group_name
  display_name          = "Maccas API Key (internal usage)"
  subscription_required = true
  published             = true
}

resource "azurerm_api_management_subscription" "maccas-policy-apim-subscription" {
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
  product_id          = azurerm_api_management_product.maccas-policy-apim.id
  display_name        = "Maccas API Key (internal usage)"
  state               = "active"
}
