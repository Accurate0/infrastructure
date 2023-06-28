terraform {
  required_providers {
    fly = {
      source  = "fly-apps/fly"
      version = "0.0.23"
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
      version = "3.5.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3"
    }
    upstash = {
      source  = "upstash/upstash"
      version = "1.4.0"
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

provider "upstash" {
  api_key = var.UPSTASH_API_KEY
  email   = var.UPSTASH_EMAIL
}

variable "UPSTASH_API_KEY" {
  type = string
}

variable "UPSTASH_EMAIL" {
  type = string
}
