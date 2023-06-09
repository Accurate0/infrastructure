module "apim-endpoints" {
  source              = "../module/apim-endpoints"
  api_name            = azurerm_api_management_api.ww3-v1.name
  api_management_name = azurerm_api_management_api.ww3-v1.api_management_name
  resource_group_name = azurerm_api_management_api.ww3-v1.resource_group_name
  api_definition      = jsondecode(file("apim-endpoints.json"))
}
