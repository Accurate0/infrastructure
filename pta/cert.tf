resource "fly_cert" "api" {
  app      = "pta-api"
  hostname = "api.perthtransport.xyz"
}
