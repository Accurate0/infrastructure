data "azurerm_resource_group" "general-api-group" {
  name = "general-api-group"
}

data "azurerm_api_management" "general-apim" {
  name                = "general-apim"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

resource "azurerm_api_management_api_version_set" "upbank-segment-version" {
  name                = "UpbankApiSegment"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "Upbank API"
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "upbank-v1" {
  name                  = "Upbank-API-v1"
  resource_group_name   = data.azurerm_resource_group.general-api-group.name
  api_management_name   = data.azurerm_api_management.general-apim.name
  revision              = "1"
  version               = "v1"
  display_name          = "Upbank API"
  path                  = "upbank"
  protocols             = ["https", "http"]
  subscription_required = false
  service_url           = aws_api_gateway_stage.api-stage.invoke_url
  version_set_id        = azurerm_api_management_api_version_set.upbank-segment-version.id

  subscription_key_parameter_names {
    header = "X-Api-Key"
    query  = "api-key"
  }
}

locals {
  endpoints = jsondecode(file("apim-endpoints.json"))
}

resource "azurerm_api_management_api_operation" "api-operation" {
  for_each = { for x in local.endpoints : x.name => x }

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

  api_name            = azurerm_api_management_api.upbank-v1.name
  api_management_name = azurerm_api_management_api.upbank-v1.api_management_name
  resource_group_name = azurerm_api_management_api.upbank-v1.resource_group_name
}

resource "azurerm_api_management_api_policy" "upbank-v1-policy" {
  api_name            = azurerm_api_management_api.upbank-v1.name
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_resource_group.general-api-group.name

  depends_on = [
    azurerm_api_management_named_value.upbank-shame-api-key
  ]
  xml_content = file("policy/upbank-shame.v1.policy.xml")
}
