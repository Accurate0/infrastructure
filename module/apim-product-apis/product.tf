resource "azurerm_api_management_product_api" "product-api" {
  for_each            = var.api_list
  api_name            = each.key
  product_id          = var.product_id
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
}
