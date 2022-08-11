terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.11.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.10.1"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "~> 0.3"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "maccas-api"
    }
  }
}
provider "azurerm" {
  features {}
}

provider "aws" {}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}
