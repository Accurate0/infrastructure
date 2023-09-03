terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.9.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.29.0"
    }
  }

  backend "s3" {
    key = "shared-applications/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
