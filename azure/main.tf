terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.10.1"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "azure"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "ARM_B2C_CLIENT_ID" {
  type = string
}

variable "ARM_B2C_CLIENT_SECRET" {
  type = string
}

variable "ARM_B2C_TENANT_ID" {
  type = string
}

provider "azurerm" {
  alias         = "b2c"
  client_id     = var.ARM_B2C_CLIENT_ID
  client_secret = var.ARM_B2C_CLIENT_SECRET
  tenant_id     = var.ARM_B2C_TENANT_ID
}
