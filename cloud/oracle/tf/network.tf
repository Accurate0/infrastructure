module "vcn" {
  source         = "oracle-terraform-modules/vcn/oci"
  version        = "2.2.0"
  compartment_id = oci_identity_compartment.paste.id
  region         = "ap-sydney-1"
  vcn_name       = "main_vcn"
  vcn_dns_label  = "pastevcndns"

  # Optional
  internet_gateway_enabled = true
  nat_gateway_enabled      = true
  service_gateway_enabled  = true
  vcn_cidr                 = "10.0.0.0/16"
}

# resource "oci_core_subnet" "paste-private-subnet" {
#   compartment_id = oci_identity_compartment.paste.id
#   vcn_id         = module.vcn.vcn_id
#   route_table_id = module.vcn.nat_route_id
#   cidr_block     = "10.0.1.0/24"
#   dns_label      = "privatepaste"
# }

resource "oci_core_subnet" "paste-public-subnet" {
  compartment_id    = oci_identity_compartment.paste.id
  vcn_id            = module.vcn.vcn_id
  route_table_id    = module.vcn.ig_route_id
  security_list_ids = [oci_core_security_list.public-security-list.id]
  dhcp_options_id   = oci_core_dhcp_options.dhcp-options.id
  cidr_block        = "10.0.0.0/24"
  dns_label         = "publicpaste"
}

resource "oci_core_dhcp_options" "dhcp-options" {
  compartment_id = oci_identity_compartment.paste.id
  vcn_id         = module.vcn.vcn_id
  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  # Optional
  display_name = "paste-dhcp-options"
}

data "oci_core_private_ips" "paste-private-ips" {
  ip_address = oci_core_instance.ubuntu_paste.private_ip
  subnet_id  = oci_core_subnet.paste-public-subnet.id
}

resource "oci_core_public_ip" "paste-public-ip" {
  display_name   = "reserved ip for paste vm"
  compartment_id = oci_identity_compartment.paste.id
  lifetime       = "RESERVED"
  private_ip_id  = data.oci_core_private_ips.paste-private-ips.private_ips[0].id
}
