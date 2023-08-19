terraform {
  required_providers {
    fly = {
      source  = "fly-apps/fly"
      version = "0.0.23"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.9.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.2"
    }
    upstash = {
      source  = "upstash/upstash"
      version = "1.4.1"
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
}
