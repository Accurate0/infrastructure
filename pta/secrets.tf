module "realtime_api_key" {
  source      = "../module/keyvault-value-output"
  secret_name = "pta-realtime-api-key"
}

module "reference_data_api_key" {
  source      = "../module/keyvault-value-output"
  secret_name = "pta-reference-data-api-key"
}

resource "null_resource" "secrets" {
  triggers = {
    api                = fly_machine.api.id
    worker             = fly_machine.worker.id
    script             = filesha1("./scripts/fly-secrets.sh")
    real_time_key      = module.realtime_api_key.secret_value
    reference_data_key = module.reference_data_api_key.secret_value
  }

  provisioner "local-exec" {
    environment = {
      "PTA_REALTIME_API_KEY"       = module.realtime_api_key.secret_value
      "PTA_REFERENCE_DATA_API_KEY" = module.reference_data_api_key.secret_value
    }

    command = "./scripts/fly-secrets.sh"
  }

  depends_on = [fly_machine.api, fly_machine.worker]
}
