resource "binarylane_server" "perth" {
  image         = "ubuntu-24.04"
  name          = "snake-street.bnr.la"
  region        = "per"
  size          = "std-4vcpu"
  port_blocking = false
}
