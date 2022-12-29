data "azurerm_resource_group" "general-api-group" {
  name = "general-api-group"
}

data "azurerm_api_management" "general-apim" {
  name                = "general-apim"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

resource "azurerm_api_management_api_version_set" "graph-segment-version" {
  name                = "GraphApiSegment"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "Graph API"
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "graph-v1" {
  name                  = "Graph-API-v1"
  resource_group_name   = data.azurerm_resource_group.general-api-group.name
  api_management_name   = data.azurerm_api_management.general-apim.name
  revision              = "1"
  version               = "v1"
  display_name          = "Graph API"
  path                  = "graph"
  protocols             = ["https", "http"]
  subscription_required = true
  subscription_key_parameter_names {
    header = "X-Api-Key"
    query  = "api-key"
  }

  service_url    = "https://graph.microsoft.com/v1.0/"
  version_set_id = azurerm_api_management_api_version_set.graph-segment-version.id
}

resource "azurerm_api_management_api_policy" "graph-v1-policy" {
  api_name            = azurerm_api_management_api.graph-v1.name
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_resource_group.general-api-group.name

  xml_content = file("policy/base.policy.xml")
}
