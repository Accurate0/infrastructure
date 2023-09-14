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
  lifecycle {
    replace_triggered_by = [
      time_rotating.terraform-access-key-rotation
    ]
  }
}

resource "time_rotating" "terraform-access-key-rotation" {
  rotation_days = 90
}
