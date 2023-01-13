resource "aws_organizations_organization" "root" {
  lifecycle {
    prevent_destroy = true
  }
}
