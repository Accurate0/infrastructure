terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.30.2"
    }
  }
  cloud {
    organization = "server"
    workspaces {
      name = "tfc"
    }
  }
}

provider "tfe" {}
