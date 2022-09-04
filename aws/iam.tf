# TODO: migrate policy attachments from IAM console

resource "aws_iam_user" "terraform" {
  name = "terraform"
}

resource "aws_iam_group" "terraform-users" {
  name = "terraform-users"
}

resource "aws_iam_group" "terraform-users-2" {
  name = "terraform-users-2"
}

resource "aws_iam_group_membership" "terraform-group" {
  name = "terraform-group"

  users = [
    aws_iam_user.terraform.name,
  ]

  group = aws_iam_group.terraform-users.name
}

resource "aws_iam_group_membership" "terraform-group-2" {
  name = "terraform-group-2"

  users = [
    aws_iam_user.terraform.name,
  ]

  group = aws_iam_group.terraform-users-2.name
}

resource "aws_iam_user" "actions" {
  name = "actions"
}
