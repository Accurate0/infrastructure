terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.9.0"
    }
  }

  backend "s3" {
    key = "cloudflare/terraform.tfstate"
  }
}

provider "cloudflare" {}
