variable "teams" {
  description = "Github teams"
  type = list(object({
    name        = string
    description = string
    privacy     = string
  }))

  default = []
}

variable "users" {
  description = "Github users"
  type = list(object({
    name = string
    team = string
    role = string
  }))

  default = []
}

variable "repositories" {
  description = "Github repositories"
  type = list(object({
    name        = string
    description = string
    visibility  = string
    has_issues = string
    has_discussions = string
    has_projects = string
    has_wiki = string
  }))

  default = []

  validation {
    condition = alltrue([
      for o in var.repositories : contains(["private", "public"], o.visibility)
    ])
    error_message = "Invalid visibility selected, only allowed fruits are: 'private', 'public'. Default 'public'"
  }
}
