terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
    github = {
      source  = "integrations/github"
      version = ">= 5.22.0"
    }
  }
}

data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}

data "aws_iam_policy_document" "deploy-role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = [for s in var.allowed_repos : format("repo:Accurate0/%s:*", s)]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

locals {
  deployment_role_name = "${var.name}-deploy-role"
}

resource "aws_iam_role" "deploy-role" {
  name               = local.deployment_role_name
  assume_role_policy = data.aws_iam_policy_document.deploy-role.json
}

resource "aws_iam_role_policy_attachment" "deploy-role-resource-access" {
  role       = aws_iam_role.deploy-role.name
  policy_arn = var.resource_access_arn
}

resource "github_actions_secret" "deploy-role" {
  for_each        = var.allowed_repos
  repository      = each.key
  secret_name     = "AWS_DEPLOY_ROLE_ARN"
  plaintext_value = aws_iam_role.deploy-role.arn
}

resource "github_actions_variable" "deploy-region" {
  for_each      = var.allowed_repos
  repository    = each.key
  variable_name = "AWS_REGION"
  value         = var.region
}
