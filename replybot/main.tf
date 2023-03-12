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
    github = {
      source  = "integrations/github"
      version = "5.3.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "replybot"
    }
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
