resource "oci_identity_compartment" "paste" {
  compartment_id = var.root_compartment_id
  description    = "pastebin"
  name           = "paste"
}
