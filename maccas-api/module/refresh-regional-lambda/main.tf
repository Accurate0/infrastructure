terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.53.0"
    }
  }
}

provider "aws" {
  region                 = var.region
  skip_region_validation = true
}

variable "region" {
  type = string
}

variable "role_arn" {
  type = string
}
