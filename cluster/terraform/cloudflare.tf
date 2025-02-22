resource "cloudflare_dns_record" "control" {
  count   = local.control_count
  zone_id = "8d993ee38980642089a2ebad74531806"
  name    = "k8s-control-${count.index + 1}.host"
  content = binarylane_server.control[count.index].public_ipv4_addresses[0]
  type    = "A"
  ttl     = 1
}

resource "cloudflare_dns_record" "agent" {
  count   = local.agent_count
  zone_id = "8d993ee38980642089a2ebad74531806"
  name    = "k8s-agent-${count.index + 1}.host"
  content = binarylane_server.agent[count.index].public_ipv4_addresses[0]
  type    = "A"
  ttl     = 1
}

resource "cloudflare_dns_record" "proxy" {
  count   = local.proxy_count
  zone_id = "8d993ee38980642089a2ebad74531806"
  name    = "k8s-proxy-${count.index + 1}.host"
  content = binarylane_server.proxy[count.index].public_ipv4_addresses[0]
  type    = "A"
  ttl     = 1
}
