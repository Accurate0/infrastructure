#!/usr/bin/env bash

terraform state pull > temporary.tfstate
aws s3 cp temporary.tfstate s3://shared-tf-state/$(basename "$PWD")/terraform.tfstate
rm temporary.tfstate
rm -rf .terraform
