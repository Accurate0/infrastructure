terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "4.33.0"
    }
  }
}

provider "oci" {
  region              = "ap-sydney-1"
  auth                = "SecurityToken"
  config_file_profile = "infrastructure"
}
