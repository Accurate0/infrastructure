terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.2"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.63.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.29.0"
    }
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "1.10.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }

  backend "s3" {
    key = "ozb/terraform.tfstate"
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
