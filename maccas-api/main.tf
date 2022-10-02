terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.28.0"
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
    azapi = {
      source  = "Azure/azapi"
      version = "0.5.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "maccas-api"
    }
  }
}

provider "azapi" {}

provider "azurerm" {
  features {}
}

provider "aws" {}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}

provider "github" {}

provider "random" {}
