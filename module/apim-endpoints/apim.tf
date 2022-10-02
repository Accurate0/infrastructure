resource "azurerm_api_management_api_operation" "api-operation" {
  for_each = { for x in var.api_definition : x.name => x }

  operation_id = "${replace(each.value.name, " ", "-")}-${each.value.method}"
  display_name = each.value.name
  url_template = each.value.url
  method       = each.value.method

  request {
    dynamic "query_parameter" {
      for_each = { for x in try(each.value.queryParameters, []) : x.name => x }
      content {
        name     = query_parameter.value.name
        type     = query_parameter.value.type
        required = query_parameter.value.required
      }
    }
  }

  dynamic "template_parameter" {
    for_each = { for x in try(each.value.templateParameters, []) : x.name => x }
    content {
      name     = template_parameter.value.name
      type     = template_parameter.value.type
      required = template_parameter.value.required
    }
  }

  api_name            = var.api_name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_api_management_api_operation_policy" "api-operation-policy" {
  for_each = { for x in var.api_definition : x.name => x if x.policyFile != null }

  api_name            = var.api_name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  operation_id        = azurerm_api_management_api_operation.api-operation[each.value.name].operation_id
  xml_content         = file(each.value.policyFile)

  depends_on = [
    azurerm_api_management_api_operation.api-operation
  ]
}
