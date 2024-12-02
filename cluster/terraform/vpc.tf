resource "binarylane_vpc" "kubernetes-vpc" {
  name     = "k8s-vpc"
  ip_range = "10.242.0.0/16"
}

