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

resource "null_resource" "secrets" {
  triggers = {
    api                = fly_machine.api.id
    worker             = fly_machine.worker.id
    script             = filesha1("./scripts/fly-secrets.sh")
    real_time_key      = module.realtime-api-key.secret_value
    reference_data_key = module.reference-data-api-key.secret_value
  }

  provisioner "local-exec" {
    environment = {
      "PTA_REALTIME_API_KEY"       = module.realtime-api-key.secret_value
      "PTA_REFERENCE_DATA_API_KEY" = module.reference-data-api-key.secret_value
    }

    command = "./scripts/fly-secrets.sh"
  }

  depends_on = [fly_machine.api, fly_machine.worker]
}

resource "vercel_project_environment_variable" "maps-js-api-key" {
  project_id = vercel_project.perthtransport.id
  key        = "VITE_MAPS_API_KEY"
  value      = google_apikeys_key.this.key_string
  target     = ["production"]
}
