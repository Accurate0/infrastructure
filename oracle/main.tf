terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.34.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.3.6"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "oracle"
    }
  }
}

variable "oracle_tenancy_id" {
  type = string
}

variable "oracle_user_id" {
  type = string
}

variable "oracle_private_key" {
  type = string
}

variable "oracle_fingerprint" {
  type = string
}

variable "instance_key" {
  type = string
}

provider "oci" {
  region       = "ap-sydney-1"
  tenancy_ocid = var.oracle_tenancy_id
  user_ocid    = var.oracle_user_id
  private_key  = var.oracle_private_key
  fingerprint  = var.oracle_fingerprint
  auth         = "ApiKey"
}

provider "cloudflare" {

}
