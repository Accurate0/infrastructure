data "terraform_remote_state" "database" {
  backend = "remote"
  config = {
    organization = "server"
    workspaces = {
      name = "azure"
    }
  }
}
