terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.99.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "weather-api"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "aws" {
}

output "http_endpoint" {
  value = "https://${azurerm_app_service.weather-api.name}.azurewebsites.net"
}
