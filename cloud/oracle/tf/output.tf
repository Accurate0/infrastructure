output "public-ip-paste" {
  value = oci_core_public_ip.paste-public-ip.ip_address
}

output "public-ip-buildkite" {
  value = oci_core_instance.ubuntu_buildkite.public_ip
}
