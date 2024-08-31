resource "binarylane_server_firewall_rules" "perth_firewall" {
  server_id = binarylane_server.perth.id

  firewall_rules = [
    {
      description           = "SSH"
      protocol              = "all"
      source_addresses      = [module.home-ip.secret_value]
      destination_addresses = binarylane_server.perth.public_ipv4_addresses
      destination_ports     = ["22"]
      action                = "accept"
    },
    {
      description           = "SSH Block"
      protocol              = "all"
      source_addresses      = ["0.0.0.0/0"]
      destination_addresses = binarylane_server.perth.public_ipv4_addresses
      destination_ports     = ["22"]
      action                = "drop"
    },
    {
      description           = "HTTP/S"
      protocol              = "all"
      source_addresses      = ["0.0.0.0/0"]
      destination_addresses = binarylane_server.perth.public_ipv4_addresses
      destination_ports     = ["80", "443"]
      action                = "accept"
    },
    {
      description           = "ping"
      protocol              = "icmp"
      source_addresses      = ["0.0.0.0/0"]
      destination_addresses = binarylane_server.perth.public_ipv4_addresses
      destination_ports     = []
      action                = "accept"
    },
    {
      description           = "drop"
      protocol              = "all"
      source_addresses      = binarylane_server.perth.public_ipv4_addresses
      destination_addresses = ["0.0.0.0/0"]
      destination_ports     = ["25", "3389"]
      action                = "drop"
    },
    {
      description           = "db ports"
      protocol              = "all"
      source_addresses      = ["0.0.0.0/0"]
      destination_addresses = binarylane_server.perth.public_ipv4_addresses
      destination_ports     = ["5432", "5433", "6379"]
      action                = "accept"
    },
  ]
}
