data "github_user" "current" {
  username = "Accurate0"
}

resource "github_repository_environment" "env" {
  for_each    = { for env in var.environments : env.name => env }
  environment = each.value.name
  repository  = var.repo

  reviewers {
    users = [data.github_user.current.id]
  }

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

locals {
  branches_per_env = flatten([
    for env_index, environment in var.environments : [
      for branch_index, branch_name in var.branches : {
        environment = environment
        branch_name = branch_name
      }
    ]
  ])
}

resource "github_repository_environment_deployment_policy" "main" {
  for_each       = { for item in local.branches_per_env : "${item.environment.name}_${item.branch_name}" => item }
  repository     = var.repo
  environment    = each.value.environment.name
  branch_pattern = each.value.branch_name
  depends_on     = [github_repository_environment.env]
}
