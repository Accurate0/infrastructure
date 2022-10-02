
resource "azurerm_api_management_api_operation" "api-operation" {
  for_each = { for x in var.api_definition : x.name => x }

  operation_id = each.value.name
  display_name = each.value.displayName
  url_template = each.value.urlTemplate
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
