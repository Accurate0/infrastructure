resource "binarylane_server_firewall_rules" "perth-uptime" {
  server_id = binarylane_server.perth-uptime.id

  firewall_rules = [
    {
      description           = "SSH"
      protocol              = "all"
      source_addresses      = ["0.0.0.0/0"]
      destination_addresses = binarylane_server.perth-uptime.public_ipv4_addresses
      destination_ports     = ["22"]
      action                = "accept"
    },
    {
      description           = "HTTP/S"
      protocol              = "all"
      source_addresses      = ["0.0.0.0/0"]
      destination_addresses = binarylane_server.perth-uptime.public_ipv4_addresses
      destination_ports     = ["80", "443"]
      action                = "accept"
    },
    {
      description           = "block remaining"
      protocol              = "all"
      source_addresses      = ["0.0.0.0/0"]
      destination_addresses = binarylane_server.perth-uptime.public_ipv4_addresses
      destination_ports     = ["49152:65535", "1024:49151"]
      action                = "drop"
    },
  ]
}

