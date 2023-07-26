resource "cloudflare_record" "worker" {
  zone_id         = var.cloudflare_zone_id
  allow_overwrite = true
  proxied         = false
  name            = "worker"
  type            = "A"
  value           = aws_eip.worker-eip.public_ip
  ttl             = 1
}

resource "cloudflare_record" "vpn" {
  zone_id         = var.cloudflare_zone_id
  allow_overwrite = true
  proxied         = false
  name            = "vpn"
  type            = "A"
  value           = aws_eip.worker-eip.public_ip
  ttl             = 1
}
