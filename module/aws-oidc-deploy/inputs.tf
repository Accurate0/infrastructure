variable "name" {
  type = string
}

variable "resource_access_policy" {
  type = any
}

variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "allowed_repos" {
  type = set(string)
}
