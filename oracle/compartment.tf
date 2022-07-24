resource "oci_identity_compartment" "arm" {
  compartment_id = var.root_compartment_id
  description    = "arm"
  name           = "arm"
}
