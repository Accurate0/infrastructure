terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.40.0"
    }
  }

  backend "s3" {
    key = "tailscale/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
