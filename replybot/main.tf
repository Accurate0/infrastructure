terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.63.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.28.1"
    }
  }

  backend "s3" {
    key = "replybot/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "aws" {
  default_tags {
    tags = {
      Project = "Replybot"
    }
  }
}
