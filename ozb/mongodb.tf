data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "mongodbatlas_roles_org_id" "current-org" {
}

variable "database-name" {
  default = "ozb-db"
}

variable "dev-database-name" {
  default = "ozb-db-dev"
}

variable "posts-collection" {
  default = "Posts"
}

resource "mongodbatlas_project" "this" {
  name   = "ozb"
  org_id = data.mongodbatlas_roles_org_id.current-org.org_id
  lifecycle {
    prevent_destroy = true
  }
}

resource "mongodbatlas_cluster" "this" {
  project_id = mongodbatlas_project.this.id
  name       = "ozb-cluster"

  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_region_name        = "AP_SOUTHEAST_2"
  provider_instance_size_name = "M0"

    lifecycle {
    prevent_destroy = true
  }
}

resource "mongodbatlas_project_ip_access_list" "anywhere-access" {
  project_id = mongodbatlas_project.this.id
  cidr_block = "0.0.0.0/0"
  comment    = "Anywhere Access"
}

resource "mongodbatlas_database_user" "ozb-user" {
  username           = "ozb-user"
  password           = random_password.ozb-user-password.result
  project_id         = mongodbatlas_project.this.id
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = var.database-name
  }

  scopes {
    name = mongodbatlas_cluster.this.name
    type = "CLUSTER"
  }

    lifecycle {
    prevent_destroy = true
  }
}

resource "mongodbatlas_database_user" "ozb-user-dev" {
  username           = "ozb-user-dev"
  password           = random_password.ozb-user-password-dev.result
  project_id         = mongodbatlas_project.this.id
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = var.dev-database-name
  }

  scopes {
    name = mongodbatlas_cluster.this.name
    type = "CLUSTER"
  }
}

# imported resource because i can't figure out how to make it
resource "mongodbatlas_event_trigger" "ozb-insert-trigger" {
  # where is app id from?
  app_id                      = "641ffb40af360b467e274794"
  config_collection           = "TriggerIds"
  config_database             = "ozb-db"
  config_full_document        = true
  config_full_document_before = false
  config_operation_types = [
    "INSERT",
  ]
  # or this config service id
  config_service_id = "641ffb40af360b467e2747a2"
  disabled          = false
  name              = "ozb-insert-trigger"
  project_id        = mongodbatlas_project.this.id
  type              = "DATABASE"
  unordered         = false

  event_processors {
    aws_eventbridge {
      config_account_id = data.aws_caller_identity.current.account_id
      config_region     = data.aws_region.current.name
    }
  }
}
