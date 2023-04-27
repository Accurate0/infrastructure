data "azurerm_resource_group" "general-api-group" {
  name = "general-api-group"
}

data "azurerm_api_management" "general-apim" {
  name                = "general-apim"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

resource "azurerm_api_management_api_version_set" "places-segment-version" {
  name                = "PlaceApiSegment"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "Places API"
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "places-v1" {
  name                  = "Places-API-v1"
  resource_group_name   = data.azurerm_resource_group.general-api-group.name
  api_management_name   = data.azurerm_api_management.general-apim.name
  revision              = "1"
  version               = "v1"
  display_name          = "Places API"
  path                  = "places"
  protocols             = ["https", "http"]
  subscription_required = true
  subscription_key_parameter_names {
    header = "X-Api-Key"
    query  = "api-key"
  }

  service_url    = "https://maps.googleapis.com/maps/api/place/"
  version_set_id = azurerm_api_management_api_version_set.places-segment-version.id
}

resource "azurerm_api_management_api_policy" "places-v1-policy" {
  api_name            = azurerm_api_management_api.places-v1.name
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_resource_group.general-api-group.name

  xml_content = file("policy/base.policy.xml")
}

resource "azurerm_api_management_api_operation" "search-operation" {
  operation_id = "search"
  display_name = "Search"
  url_template = "/place"
  method       = "GET"

  api_name            = azurerm_api_management_api.places-v1.name
  api_management_name = azurerm_api_management_api.places-v1.api_management_name
  resource_group_name = azurerm_api_management_api.places-v1.resource_group_name

  request {
    query_parameter {
      name     = "text"
      type     = "string"
      required = true
    }
  }
}

resource "azurerm_api_management_api_operation_policy" "search-operation-policy" {
  api_name            = azurerm_api_management_api_operation.search-operation.api_name
  api_management_name = azurerm_api_management_api_operation.search-operation.api_management_name
  resource_group_name = azurerm_api_management_api_operation.search-operation.resource_group_name
  operation_id        = azurerm_api_management_api_operation.search-operation.operation_id

  depends_on = [
    module.google-places-api-key
  ]

  xml_content = file("policy/search.policy.xml")
}
