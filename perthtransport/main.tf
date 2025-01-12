terraform {
  required_providers {
    fly = {
      source  = "fly-apps/fly"
      version = "0.0.23"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4"
    }
    null = {
      source  = "hashicorp/null"
      version = "~>3"
    }
    vercel = {
      source  = "vercel/vercel"
      version = ">= 1"
    }
    google = {
      source  = "hashicorp/google"
      version = ">= 4"
    }
    github = {
      source  = "integrations/github"
      version = ">= 5"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5"
    }
  }

  backend "s3" {
    key = "perthtransport/terraform.tfstate"
  }
}

provider "fly" {
}

provider "azurerm" {
  features {}
}
