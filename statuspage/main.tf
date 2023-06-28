terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.28.1"
    }
  }

  backend "s3" {
    key = "statuspage/terraform.tfstate"
  }
}

provider "aws" {
  default_tags {
    tags = {
      Project = "statuspage"
    }
  }
}
