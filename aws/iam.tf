resource "aws_iam_user" "terraform" {
  name = "terraform"
}

resource "aws_iam_group" "terraform-main" {
  name = "terraform-main"
}

resource "aws_iam_group_membership" "terraform-main-membership" {
  name = "terraform-main-membership"

  users = [
    aws_iam_user.terraform.name,
  ]

  group = aws_iam_group.terraform-main.name
}

resource "aws_iam_access_key" "terraform-access-key" {
  user = "terraform"
}

resource "aws_iam_user" "actions" {
  name = "actions"
}

resource "aws_iam_access_key" "actions-access-key" {
  user = "actions"
}

resource "aws_iam_group" "actions-main" {
  name = "actions-main"
}

resource "aws_iam_group_membership" "actions-main-membership" {
  name = "actions-main-membership"

  users = [
    aws_iam_user.actions.name,
  ]

  group = aws_iam_group.actions-main.name
}
