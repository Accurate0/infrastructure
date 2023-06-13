resource "fly_cert" "api" {
  app      = fly_app.api.name
  hostname = "api.perthtransport.xyz"
}
