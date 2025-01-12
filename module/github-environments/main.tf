terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.4.0"
    }
  }
}

variable "environments" {
  type = list(object({
    name = string
  }))
}

variable "repo" {
  type = string
}

variable "branches" {
  type    = set(string)
  default = ["main"]
}
