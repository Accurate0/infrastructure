
data "terraform_remote_state" "ww3" {
  backend = "remote"
  config = {
    organization = "server"
    workspaces = {
      name = "ww3-api"
    }
  }
}

resource "azurerm_api_management_api_version_set" "ww3-segment-version" {
  name                = "WW3ApiSegment"
  resource_group_name = azurerm_resource_group.general-api-group.name
  api_management_name = azurerm_api_management.general-apim.name
  display_name        = "WW3 API"
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "ww3-v2" {
  name                  = "WW3-API-v2"
  resource_group_name   = azurerm_resource_group.general-api-group.name
  api_management_name   = azurerm_api_management.general-apim.name
  revision              = "1"
  version               = "v2"
  display_name          = "WW3 API"
  path                  = "ww3"
  protocols             = ["https", "http"]
  subscription_required = false
  service_url           = data.terraform_remote_state.ww3.outputs.http_endpoint
  version_set_id        = azurerm_api_management_api_version_set.ww3-segment-version.id
}

resource "azurerm_api_management_api" "ww3-v1" {
  name                  = "WW3-API-v1"
  resource_group_name   = azurerm_resource_group.general-api-group.name
  api_management_name   = azurerm_api_management.general-apim.name
  revision              = "1"
  version               = "v1"
  display_name          = "WW3 API"
  path                  = "ww3"
  protocols             = ["https", "http"]
  subscription_required = false
  service_url           = "https://ww3.anurag.sh/api/v1"
  version_set_id        = azurerm_api_management_api_version_set.ww3-segment-version.id
}

resource "azurerm_api_management_api_policy" "ww3-v1-policy" {
  api_name            = azurerm_api_management_api.ww3-v1.name
  api_management_name = azurerm_api_management.general-apim.name
  resource_group_name = azurerm_resource_group.general-api-group.name

  xml_content = file("policy/ww3.policy.xml")
}

resource "azurerm_api_management_api_policy" "ww3-v2-policy" {
  api_name            = azurerm_api_management_api.ww3-v2.name
  api_management_name = azurerm_api_management.general-apim.name
  resource_group_name = azurerm_resource_group.general-api-group.name

  xml_content = file("policy/ww3.policy.xml")
}
