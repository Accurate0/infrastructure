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
      name = "sandbox"
    }
  }
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::932929614071:role/development"
  }
}
