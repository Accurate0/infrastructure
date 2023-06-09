terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.10.1"
    }
  }

  backend "s3" {
    key = "cloudflare/terraform.tfstate"
  }
}

provider "cloudflare" {}
