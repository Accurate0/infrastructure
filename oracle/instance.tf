locals {
  ubuntu_image = {
    source_id = "ocid1.image.oc1.ap-sydney-1.aaaaaaaaktqfrmgg3dhnu4kiypzczqbkah3vawe6tf7ur2cxjenkeznrau5a"
  }
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = oci_identity_compartment.arm.compartment_id
}

resource "oci_core_instance" "ubuntu_arm_oracle" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.arm.id
  shape               = "VM.Standard.A1.Flex"
  shape_config {
    memory_in_gbs = "24"
    ocpus         = "4"
  }
  source_details {
    source_id   = local.ubuntu_image.source_id
    source_type = "image"
  }

  display_name = "ubuntu_arm_oracle"
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.arm-public-subnet.id
  }

  metadata = {
    ssh_authorized_keys = var.instance_key
  }
}
