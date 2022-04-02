resource "azurerm_api_management_api_version_set" "lamp-segment-version" {
  name                = "LampApiSegment"
  resource_group_name = azurerm_resource_group.general-api-group.name
  api_management_name = azurerm_api_management.general-apim.name
  display_name        = "Lamp API"
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "lamp-v1" {
  name                  = "Lamp-API-v1"
  resource_group_name   = azurerm_resource_group.general-api-group.name
  api_management_name   = azurerm_api_management.general-apim.name
  revision              = "1"
  version               = "v1"
  display_name          = "Lamp API"
  path                  = "lamp"
  protocols             = ["https", "http"]
  subscription_required = true
  subscription_key_parameter_names {
    header = "X-Api-Key"
    query  = "api-key"
  }
  service_url    = "https://home.anurag.sh/api/services/light/"
  version_set_id = azurerm_api_management_api_version_set.lamp-segment-version.id
}

resource "azurerm_api_management_api_policy" "lamp-v1-policy" {
  api_name            = azurerm_api_management_api.lamp-v1.name
  api_management_name = azurerm_api_management.general-apim.name
  resource_group_name = azurerm_resource_group.general-api-group.name

  xml_content = file("policy/lamp.policy.xml")
}

resource "azurerm_api_management_api_operation" "lamp-off" {
  operation_id        = "lamp-off"
  api_name            = azurerm_api_management_api.lamp-v1.name
  api_management_name = azurerm_api_management_api.lamp-v1.api_management_name
  resource_group_name = azurerm_api_management_api.lamp-v1.resource_group_name
  display_name        = "Off"
  method              = "POST"
  url_template        = "/off"

  response {
    status_code = 200
  }
}

resource "azurerm_api_management_api_operation" "lamp-on" {
  operation_id        = "lamp-on"
  api_name            = azurerm_api_management_api.lamp-v1.name
  api_management_name = azurerm_api_management_api.lamp-v1.api_management_name
  resource_group_name = azurerm_api_management_api.lamp-v1.resource_group_name
  display_name        = "On"
  method              = "POST"
  url_template        = "/on"

  response {
    status_code = 200
  }
}

resource "azurerm_api_management_api_operation" "lamp-state" {
  operation_id        = "lamp-state"
  api_name            = azurerm_api_management_api.lamp-v1.name
  api_management_name = azurerm_api_management_api.lamp-v1.api_management_name
  resource_group_name = azurerm_api_management_api.lamp-v1.resource_group_name
  display_name        = "Status"
  method              = "GET"
  url_template        = "/state"

  response {
    status_code = 200
  }
}

resource "azurerm_api_management_subscription" "lamp-subscription" {
  api_management_name = azurerm_api_management.general-apim.name
  resource_group_name = azurerm_api_management.general-apim.resource_group_name
  api_id              = azurerm_api_management_api.lamp-v1.id
  display_name        = "Lamp API"
  state               = "active"
}

variable "home_assistant_api_key" {
  type      = string
  sensitive = true
}

resource "azurerm_api_management_named_value" "home-assistant-api-key" {
  name                = "home-assistant-api-key"
  resource_group_name = azurerm_resource_group.general-api-group.name
  api_management_name = azurerm_api_management.general-apim.name
  display_name        = "HomeAssistantApiKey"
  secret              = true
  value               = var.home_assistant_api_key
}
