data "azurerm_application_insights" "general-ai" {
  name                = "general-ai"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

module "ai" {
  source              = "../module/apim-ai-logger"
  api_name            = azurerm_api_management_api.maccas-v2.name
  apim_name           = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  ai_name             = data.azurerm_application_insights.general-ai.name
}
