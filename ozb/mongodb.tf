data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "mongodbatlas_roles_org_id" "current-org" {
}

variable "database-name" {
  default = "ozb-db"
}

variable "posts-collection" {
  default = "Posts"
}

resource "mongodbatlas_project" "this" {
  name   = "ozb"
  org_id = data.mongodbatlas_roles_org_id.current-org.org_id
}

resource "mongodbatlas_cluster" "this" {
  project_id = mongodbatlas_project.this.id
  name       = "ozb-cluster"

  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_region_name        = "AP_SOUTHEAST_2"
  provider_instance_size_name = "M0"
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
}

## triggers???
