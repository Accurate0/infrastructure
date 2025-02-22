resource "cloudflare_record" "oracle" {
  zone_id         = var.cloudflare_zone_id
  name            = "oracle"
  value           = oci_core_instance.ubuntu_arm_oracle.public_ip
  type            = "A"
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "oracle-inf-k8s" {
  zone_id         = "8d993ee38980642089a2ebad74531806"
  name            = "oracle.host"
  value           = oci_core_instance.ubuntu_arm_oracle.public_ip
  type            = "A"
  ttl             = 1
  allow_overwrite = true
}

variable "cloudflare_zone_id" {
  type      = string
  sensitive = true
  default   = "ccdf653cce6321100fecab81f8f2d9ff"
}
