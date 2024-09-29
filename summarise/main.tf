terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.40.0"
    }
  }

  backend "s3" {
    key = "summarise/terraform.tfstate"
  }
}

provider "github" {}

provider "azurerm" {
  features {}
}