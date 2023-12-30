resource "cloudflare_record" "uptime" {
  zone_id = var.cloudflare_zone_id
  name    = "uptime"
  value   = "worker.anurag.sh"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}
