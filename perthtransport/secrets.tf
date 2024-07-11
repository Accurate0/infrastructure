module "realtime-api-key" {
  source      = "../module/keyvault-value-output"
  secret_name = "pta-realtime-api-key"
}

module "reference-data-api-key" {
  source      = "../module/keyvault-value-output"
  secret_name = "pta-reference-data-api-key"
}

module "google-maps-api-key" {
  source       = "../module/keyvault-value"
  secret_name  = "pta-maps-js-api-key"
  secret_value = google_apikeys_key.this.key_string
}
