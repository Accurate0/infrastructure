resource "binarylane_server" "perth" {
  image             = "ubuntu-24.04"
  name              = "snake-street.bnr.la"
  region            = "per"
  size              = "std-4vcpu"
  port_blocking     = false
  vpc_id            = binarylane_vpc.perth-vpc.id
  public_ipv4_count = 1
}

resource "binarylane_server" "perth-uptime" {
  image             = "ubuntu-24.04"
  name              = "perth-uptime"
  region            = "per"
  size              = "std-min"
  port_blocking     = true
  wait_for_create   = 300
  vpc_id            = binarylane_vpc.perth-vpc.id
  public_ipv4_count = 1
}

