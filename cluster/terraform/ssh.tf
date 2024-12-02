resource "tls_private_key" "key" {
  algorithm = "ED25519"
}

resource "binarylane_ssh_key" "ssh-key" {
  name = "k8s-ssh-key"
  # the fuck?
  public_key = "${chomp(tls_private_key.key.public_key_openssh)} "
}

data "binarylane_ssh_key" "default-ssh-key" {
  id = 4403
}
