terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.54.0"
    }
  }
}

provider "aws" {
  region = var.region
}

variable "region" {
  type = string
}

variable "role_arn" {
  type = string
}
