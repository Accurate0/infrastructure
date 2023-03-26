locals {
  repos = toset(["maccas-api", "replybot", "isitww3yet-api", "resume", "ozb"])
}

data "aws_caller_identity" "current" {}

resource "github_actions_secret" "repos-with-actions-key-id" {
  for_each = local.repos

  repository      = each.key
  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = aws_iam_access_key.actions-access-key.id
}

resource "github_actions_secret" "repos-with-actions-secret" {
  for_each = local.repos

  repository      = each.key
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = aws_iam_access_key.actions-access-key.secret
}

resource "github_actions_secret" "repos-with-account-id" {
  for_each = local.repos

  repository      = each.key
  secret_name     = "AWS_ACCOUNT_ID"
  plaintext_value = data.aws_caller_identity.current.account_id
}

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
