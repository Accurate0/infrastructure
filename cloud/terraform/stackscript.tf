resource "linode_stackscript" "script-init" {
  label       = "init a server"
  description = "inits a new server"
  script      = file("init.sh")
  images      = ["linode/arch"]
}
