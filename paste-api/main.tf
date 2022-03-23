terraform {
  cloud {
    organization = "server"
    workspaces {
      name = "paste-api"
    }
  }
}

module "lambda" {
  source      = "../module/aws-lambda-http-trigger"
  api_name    = "PasteApi"
  api_runtime = "go1.x"
  api_handler = "main"
}
