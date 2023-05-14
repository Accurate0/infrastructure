terraform {
  required_providers {
    upstash = {
      source  = "upstash/upstash"
      version = ">= 1.3.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3"
    }
  }
}

provider "upstash" {
  api_key = var.UPSTASH_API_KEY
  email   = var.UPSTASH_EMAIL
}

provider "azurerm" {
  features {}
}
