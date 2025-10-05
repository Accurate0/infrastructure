# resource "cloudflare_dns_record" "uptime" {
#   zone_id = "8d993ee38980642089a2ebad74531806"
#   name    = "uptime.host"
#   content = binarylane_server.perth-uptime.public_ipv4_addresses[0]
#   type    = "A"
#   ttl     = 1
# }
