resource "random_password" "ozb-user-password" {
  length  = 50
  special = false
}

resource "random_password" "ozb-user-password-dev" {
  length  = 50
  special = false
}

