# TODO: migrate policy attachments from IAM console

resource "aws_iam_user" "terraform" {
  name = "terraform"
}

resource "aws_iam_user" "actions" {
  name = "actions"
}
