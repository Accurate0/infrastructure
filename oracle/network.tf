module "vcn" {
  source         = "oracle-terraform-modules/vcn/oci"
  version        = "3.6.0"
  compartment_id = oci_identity_compartment.arm.id
  region         = "ap-sydney-1"
  vcn_name       = "arm_vcn"
  vcn_dns_label  = "armvcndns"

  # Optional
  create_internet_gateway = true
  create_nat_gateway      = false
  create_service_gateway  = false
  vcn_cidrs               = ["10.0.0.0/16"]
}

resource "oci_core_subnet" "arm-public-subnet" {
  compartment_id    = oci_identity_compartment.arm.id
  vcn_id            = module.vcn.vcn_id
  route_table_id    = module.vcn.ig_route_id
  security_list_ids = [oci_core_security_list.public-security-list.id]
  dhcp_options_id   = oci_core_dhcp_options.dhcp-options.id
  cidr_block        = "10.0.0.0/24"
  dns_label         = "publicarm"
}

resource "oci_core_dhcp_options" "dhcp-options" {
  compartment_id = oci_identity_compartment.arm.id
  vcn_id         = module.vcn.vcn_id
  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }
}
