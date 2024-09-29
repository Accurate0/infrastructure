resource "binarylane_vpc" "perth-vpc" {
  name     = "internal-vpc"
  ip_range = "10.240.0.0/16"
}

