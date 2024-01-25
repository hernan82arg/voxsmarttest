remote_state {
  backend = "local"
  config = {
    path = "${get_parent_terragrunt_dir()}/${path_relative_to_include()}/terraform.tfstate"
  }

  generate = {
    path = "backend.tf"
    if_exists = "overwrite"
  }
}

locals {
  folder_name = path_relative_to_include()
  plan_path   = "${get_parent_terragrunt_dir()}/.terraform/${local.folder_name}/output.tfplan"
}

terraform {
  before_hook "globals" {
    commands = get_terraform_commands_that_need_vars()
    execute  = ["ln", "-sf", "${get_parent_terragrunt_dir()}/globals.tf", "."]
  }

  before_hook "create plan output directory" {
    commands = ["plan"]
    execute  = ["mkdir", "-p", "${get_parent_terragrunt_dir()}/.terraform/${local.folder_name}"]
  }

  extra_arguments "globals" {
    commands = ["plan", "show", "import"]

    required_var_files = [
      "${get_parent_terragrunt_dir()}/globals.tfvars"
    ]
  }

  extra_arguments "plan" {
    commands  = ["plan"]
    arguments = ["-out=${local.plan_path}"]
  }

  extra_arguments "apply" {
    commands  = ["apply"]
    arguments = ["${local.plan_path}"]
  }

  extra_arguments "show" {
    commands  = ["show"]
    arguments = ["${local.plan_path}"]
  }
}
