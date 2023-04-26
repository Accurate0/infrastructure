output "mongodb-dev-connection-string" {
  value     = "mongodb+srv://${mongodbatlas_database_user.ozb-user-dev.username}:${random_password.ozb-user-password-dev.result}@${trimprefix(mongodbatlas_cluster.this.srv_address, "mongodb+srv://")}/${var.dev-database-name}"
  sensitive = true
}
