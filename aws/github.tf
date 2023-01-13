locals {
  repos = toset(["maccas-api", "replybot", "isitww3yet-api"])
}

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
