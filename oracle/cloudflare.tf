resource "cloudflare_record" "oracle1" {
  zone_id         = var.cloudflare_zone_id
  name            = "oracle1"
  value           = oci_core_public_ip.paste-public-ip.ip_address
  type            = "A"
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "oracle2" {
  zone_id         = var.cloudflare_zone_id
  name            = "oracle2"
  value           = oci_core_instance.ubuntu_oracle2.public_ip
  type            = "A"
  ttl             = 1
  allow_overwrite = true
}

variable "cloudflare_zone_id" {
  type      = string
  sensitive = true
}
