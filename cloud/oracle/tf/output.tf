output "public-ip" {
  value = oci_core_public_ip.paste-public-ip.ip_address
}
