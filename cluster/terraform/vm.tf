resource "binarylane_server" "control" {
  count             = local.control_count
  image             = "ubuntu-24.04"
  name              = "k8s-control-${count.index + 1}"
  region            = "per"
  memory            = 4096
  disk              = 100
  size              = "std-2vcpu"
  port_blocking     = false
  public_ipv4_count = 1
  vpc_id            = binarylane_vpc.kubernetes-vpc.id
  ssh_keys          = [binarylane_ssh_key.ssh-key.id, data.binarylane_ssh_key.default-ssh-key.id]
}

locals {
  control_count = 1
  agent_count   = 0
  proxy_count   = 2
}

resource "binarylane_server" "agent" {
  count             = local.agent_count
  image             = "ubuntu-24.04"
  name              = "k8s-agent-${count.index + 1}"
  region            = "per"
  disk              = 20
  size              = "std-min"
  port_blocking     = false
  public_ipv4_count = 1
  vpc_id            = binarylane_vpc.kubernetes-vpc.id
  ssh_keys          = [binarylane_ssh_key.ssh-key.id, data.binarylane_ssh_key.default-ssh-key.id]
}

resource "binarylane_server" "proxy" {
  count             = local.proxy_count
  image             = "ubuntu-24.04"
  name              = "k8s-proxy-${count.index + 1}"
  region            = "per"
  size              = "std-min"
  disk              = 20
  port_blocking     = false
  public_ipv4_count = 1
  vpc_id            = binarylane_vpc.kubernetes-vpc.id
  ssh_keys          = [binarylane_ssh_key.ssh-key.id, data.binarylane_ssh_key.default-ssh-key.id]
}

