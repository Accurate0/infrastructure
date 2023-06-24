terraform {
  required_providers {
    fly = {
      source  = "fly-apps/fly"
      version = "0.0.21"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.8.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3"
    }
  }

  backend "s3" {
    key = "redis/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "fly" {
  useinternaltunnel    = true
  internaltunnelorg    = "redis-cluster"
  internaltunnelregion = "syd"
}
