variable "api_name" {
  type = string
}

variable "api_management_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "api_definition" {
  type = list(object(
    {
      name   = string,
      method = string,
      url    = string,
      queryParameters = list(object({
        name     = string,
        type     = string,
        required = bool,
      }))
      templateParameters = list(object({
        name     = string,
        type     = string,
        required = bool,
      }))
      policyFile = optional(string),
    }
  ))
}
