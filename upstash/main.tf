terraform {
  required_providers {
    upstash = {
      source  = "upstash/upstash"
      version = "1.4.0"
    }
  }

  backend "s3" {
    key = "upstash/terraform.tfstate"
  }
}

provider "upstash" {
  api_key = var.UPSTASH_API_KEY
  email   = var.UPSTASH_EMAIL
}

variable "UPSTASH_API_KEY" {
  type = string
}

variable "UPSTASH_EMAIL" {
  type = string
}
