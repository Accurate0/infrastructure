data "azurerm_resource_group" "general-api-group" {
  name = "general-api-group"
}

data "azurerm_api_management" "general-apim" {
  name                = "general-apim"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

resource "azurerm_api_management_api_version_set" "light-segment-version" {
  name                = "LightApiSegment"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "Light API"
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "light-v1" {
  name                  = "Light-API-v1"
  resource_group_name   = data.azurerm_resource_group.general-api-group.name
  api_management_name   = data.azurerm_api_management.general-apim.name
  revision              = "1"
  version               = "v1"
  display_name          = "Light API"
  path                  = "light"
  protocols             = ["https", "http"]
  subscription_required = true
  subscription_key_parameter_names {
    header = "X-Api-Key"
    query  = "api-key"
  }
  service_url    = "https://home.anurag.sh/api/services/light/"
  version_set_id = azurerm_api_management_api_version_set.light-segment-version.id
}

resource "azurerm_api_management_api_policy" "light-v1-policy" {
  api_name            = azurerm_api_management_api.light-v1.name
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_resource_group.general-api-group.name

  xml_content = file("policy/light.policy.xml")
}

locals {
  api-list = [{
    operation_id = "light-off"
    display_name = "Light Off"
    url_template = "/off/{lightName}"
    method       = "POST"
    },
    {
      operation_id = "light-on"
      display_name = "Light On"
      url_template = "/on/{lightName}"
      method       = "POST"
    },
    {
      operation_id = "light-state"
      display_name = "Light Status"
      url_template = "/state/{lightName}"
      method       = "GET"
    }
  ]
}

resource "azurerm_api_management_api_operation" "light-api-operations" {
  count        = length(local.api-list)
  operation_id = local.api-list[count.index].operation_id
  display_name = local.api-list[count.index].display_name
  url_template = local.api-list[count.index].url_template
  method       = local.api-list[count.index].method

  api_name            = azurerm_api_management_api.light-v1.name
  api_management_name = azurerm_api_management_api.light-v1.api_management_name
  resource_group_name = azurerm_api_management_api.light-v1.resource_group_name

  template_parameter {
    name     = "lightName"
    required = true
    type     = "string"
  }
  response {
    status_code = 200
  }
}
