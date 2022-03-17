terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.99.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.10.1"
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

provider "aws" {}
provider "cloudflare" {}
