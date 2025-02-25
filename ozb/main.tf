terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4"
    }
    github = {
      source  = "integrations/github"
      version = ">= 5"
    }
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = ">= 1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3"
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
