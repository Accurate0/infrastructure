resource "binarylane_server_firewall_rules" "kubernetes-firewall" {
  count     = local.control_count
  server_id = binarylane_server.control[count.index].id

  firewall_rules = [
    {
      description           = "allow https"
      protocol              = "all"
      source_addresses      = ["0.0.0.0/0"]
      destination_addresses = ["0.0.0.0/0"]
      destination_ports     = ["80", "443"]
      action                = "accept"
    },
    {
      description           = "allow ssh"
      protocol              = "all"
      source_addresses      = ["0.0.0.0/0"]
      destination_addresses = ["0.0.0.0/0"]
      destination_ports     = ["22"]
      action                = "accept"
    },
    {
      description           = "block remaining"
      protocol              = "all"
      source_addresses      = ["0.0.0.0/0"]
      destination_addresses = binarylane_server.control[count.index].public_ipv4_addresses
      destination_ports     = ["49152:65535", "1024:49151", "1:1024"]
      action                = "drop"
    },
  ]
}


resource "binarylane_server_firewall_rules" "kubernetes-agent-firewall" {
  count     = local.agent_count
  server_id = binarylane_server.agent[count.index].id

  firewall_rules = [
    {
      description           = "allow https"
      protocol              = "all"
      source_addresses      = ["0.0.0.0/0"]
      destination_addresses = ["0.0.0.0/0"]
      destination_ports     = ["80", "443"]
      action                = "accept"
    },
    {
      description           = "allow ssh"
      protocol              = "all"
      source_addresses      = ["0.0.0.0/0"]
      destination_addresses = ["0.0.0.0/0"]
      destination_ports     = ["22"]
      action                = "accept"
    },
    {
      description           = "block remaining"
      protocol              = "all"
      source_addresses      = ["0.0.0.0/0"]
      destination_addresses = binarylane_server.agent[count.index].public_ipv4_addresses
      destination_ports     = ["49152:65535", "1024:49151", "1:1024"]
      action                = "drop"
    },
  ]
}

resource "binarylane_server_firewall_rules" "kubernetes-proxy-firewall" {
  count     = local.proxy_count
  server_id = binarylane_server.proxy[count.index].id

  firewall_rules = [
    {
      description           = "allow https"
      protocol              = "all"
      source_addresses      = ["0.0.0.0/0"]
      destination_addresses = ["0.0.0.0/0"]
      destination_ports     = ["80", "443"]
      action                = "accept"
    },
    {
      description           = "allow minecraft"
      protocol              = "all"
      source_addresses      = ["0.0.0.0/0"]
      destination_addresses = ["0.0.0.0/0"]
      destination_ports     = ["25565"]
      action                = "accept"
    },
    {
      description           = "allow ssh"
      protocol              = "all"
      source_addresses      = ["0.0.0.0/0"]
      destination_addresses = ["0.0.0.0/0"]
      destination_ports     = ["22"]
      action                = "accept"
    },
    {
      description           = "block remaining"
      protocol              = "all"
      source_addresses      = ["0.0.0.0/0"]
      destination_addresses = binarylane_server.proxy[count.index].public_ipv4_addresses
      destination_ports     = ["49152:65535", "1024:49151", "1:1024"]
      action                = "drop"
    },
  ]
}
