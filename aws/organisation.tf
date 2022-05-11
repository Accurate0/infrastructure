resource "aws_organizations_organization" "root" {
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_organizations_organizational_unit" "development" {
  name      = "development"
  parent_id = aws_organizations_organization.root.roots[0].id

  lifecycle {
    prevent_destroy = true
  }
}
