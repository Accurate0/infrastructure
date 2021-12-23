terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "4.33.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.2.0"
    }
    linode = {
      source  = "linode/linode"
      version = "1.25.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "infrastructure"
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

variable "linode_token" {
  type = string
}

provider "linode" {
  token = var.linode_token
}
