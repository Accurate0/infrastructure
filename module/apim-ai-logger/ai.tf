data "azurerm_resource_group" "group" {
  name = var.resource_group_name
}

data "azurerm_api_management" "apim" {
  name                = var.apim_name
  resource_group_name = data.azurerm_resource_group.group.name
}

data "azurerm_application_insights" "ai" {
  name                = var.ai_name
  resource_group_name = data.azurerm_resource_group.group.name
}

resource "azurerm_api_management_logger" "apim-logger" {
  name                = "${var.api_name}-apim-logger"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.group.name
  resource_id         = data.azurerm_application_insights.ai.id
  buffered            = false
  application_insights {
    instrumentation_key = data.azurerm_application_insights.ai.instrumentation_key
  }
}

resource "azurerm_api_management_api_diagnostic" "api-diag" {
  identifier               = "applicationinsights"
  resource_group_name      = data.azurerm_resource_group.group.name
  api_management_name      = data.azurerm_api_management.apim.name
  api_name                 = var.api_name
  api_management_logger_id = azurerm_api_management_logger.apim-logger.id

  sampling_percentage       = 100.0
  always_log_errors         = true
  log_client_ip             = true
  verbosity                 = "verbose"
  http_correlation_protocol = "W3C"

  frontend_request {
    body_bytes = 2048
    headers_to_log = [
      "content-type",
      "accept",
      "origin",
      "traceparent",
    ]
  }

  frontend_response {
    body_bytes = 2048
    headers_to_log = [
      "content-type",
      "content-length",
      "origin",
      "traceparent",
    ]
  }

  backend_request {
    body_bytes = 2048
    headers_to_log = [
      "content-type",
      "accept",
      "origin",
      "traceparent",
    ]
  }

  backend_response {
    body_bytes = 2048
    headers_to_log = [
      "content-type",
      "content-length",
      "origin",
      "traceparent",
    ]
  }
}
