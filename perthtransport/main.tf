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
    vercel = {
      source  = "vercel/vercel"
      version = "~> 0.13"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.59.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.22.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.1.0"
    }
  }

  backend "s3" {
    key = "perthtransport/terraform.tfstate"
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
