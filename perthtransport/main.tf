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
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "~> 0.13"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.71.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.29.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.8.0"
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
