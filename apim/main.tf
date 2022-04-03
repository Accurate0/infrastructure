terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "apim"
    }
  }
}

provider "azurerm" {
  features {
    api_management {
      purge_soft_delete_on_destroy = true
    }
  }
}
