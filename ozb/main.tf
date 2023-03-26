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
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "1.8.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "ozb"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "aws" {
  default_tags {
    tags = {
      Project = "ozb"
    }
  }
}

provider "mongodbatlas" {
}
