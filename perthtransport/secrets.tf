module "realtime-api-key" {
  source      = "../module/keyvault-value-output"
  secret_name = "pta-realtime-api-key"
}

module "reference-data-api-key" {
  source      = "../module/keyvault-value-output"
  secret_name = "pta-reference-data-api-key"
}

module "vercel-org-id" {
  source      = "../module/keyvault-value-output"
  secret_name = "vercel-org-id"
}

module "google-maps-api-key" {
  source       = "../module/keyvault-value"
  secret_name  = "pta-maps-js-api-key"
  secret_value = google_apikeys_key.this.key_string
}

resource "vercel_project_environment_variable" "maps-js-api-key" {
  project_id = vercel_project.perthtransport.id
  key        = "VITE_MAPS_API_KEY"
  value      = google_apikeys_key.this.key_string
  target     = ["production"]
}
