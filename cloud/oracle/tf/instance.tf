locals {
  ubuntu_image = {
    source_id = "ocid1.image.oc1.ap-sydney-1.aaaaaaaarykwucuw32pt4m7gs7aume5gkatkgckzjq4kfhsm2l7sg4lq2b6a"
  }
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = oci_identity_compartment.paste.compartment_id
}

data "template_file" "user_data" {
  template = file("../init.yaml")
}

resource "oci_core_instance" "ubuntu_paste" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.paste.id
  shape               = "VM.Standard.E2.1.Micro"
  source_details {
    source_id   = local.ubuntu_image.source_id
    source_type = "image"
  }

  display_name = "paste_vms"
  create_vnic_details {
    assign_public_ip = false
    subnet_id        = oci_core_subnet.paste-public-subnet.id
  }

  metadata = {
    ssh_authorized_keys = file("./instance_key.pub")
    user_data           = base64encode(data.template_file.user_data.rendered)
  }
}

resource "oci_core_instance" "ubuntu_buildkite" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.paste.id
  shape               = "VM.Standard.E2.1.Micro"
  source_details {
    source_id   = local.ubuntu_image.source_id
    source_type = "image"
  }

  display_name = "buildkite_vms"
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.paste-public-subnet.id
  }

  metadata = {
    ssh_authorized_keys = file("./instance_key.pub")
    user_data           = base64encode(data.template_file.user_data.rendered)
  }
}
