terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4"
    }
    github = {
      source  = "integrations/github"
      version = "~>5"
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
