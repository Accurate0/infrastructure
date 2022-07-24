resource "cloudflare_record" "oracle" {
  zone_id         = var.cloudflare_zone_id
  name            = "oracle"
  value           = oci_core_instance.ubuntu_arm_oracle.public_ip
  type            = "A"
  ttl             = 1
  allow_overwrite = true
}

variable "cloudflare_zone_id" {
  type      = string
  sensitive = true
}
