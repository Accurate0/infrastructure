resource "github_actions_secret" "infra-repo-key-id" {
  repository      = "infrastructure"
  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = aws_iam_access_key.terraform-access-key.id
}

resource "github_actions_secret" "infra-repo-secret" {
  repository      = "infrastructure"
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = aws_iam_access_key.terraform-access-key.secret
}

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}
