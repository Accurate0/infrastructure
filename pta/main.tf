terraform {
  required_providers {
    fly = {
      source  = "fly-apps/fly"
      version = "0.0.22"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.7.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }

  backend "s3" {
    key = "pta/terraform.tfstate"
  }
}

provider "fly" {
  useinternaltunnel    = true
  internaltunnelorg    = "pta"
  internaltunnelregion = "syd"
}

provider "azurerm" {
  features {}
}
