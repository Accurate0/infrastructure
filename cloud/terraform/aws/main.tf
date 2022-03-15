terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "aws"
    }
  }
}

provider "aws" {
}