terraform {
  source = "${local.blueprint_repository}//${local.component_name}?ref=v${local.component_version}"

  before_hook "configure_providers" {
    commands = get_terraform_commands_that_need_locking()
    execute  = ["${local.repo_root}/_bin/configure-providers.sh"]
  }

}

locals {
  repo_root  = run_cmd("--terragrunt-quiet", "git", "rev-parse", "--show-toplevel")

  blueprint_repository = "git::https://github.com/Paulo-Rogerio/terraform-blueprints.git"

  # Automatically load account and region-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl")).locals

  # Child component values
  component_create  = tobool(run_cmd("--terragrunt-quiet", "${local.repo_root}/_bin/read-component-value.sh", "component_create", "${local.repo_root}/${path_relative_to_include()}/"))
  component_destroy = tobool(run_cmd("--terragrunt-quiet", "${local.repo_root}/_bin/read-component-value.sh", "component_destroy", "${local.repo_root}/${path_relative_to_include()}/"))
  component_name    = tostring(run_cmd("--terragrunt-quiet", "${local.repo_root}/_bin/read-component-value.sh", "component_name", "${local.repo_root}/${path_relative_to_include()}/"))
  component_version = tostring(run_cmd("--terragrunt-quiet", "${local.repo_root}/_bin/read-component-value.sh", "component_version", "${local.repo_root}/${path_relative_to_include()}/"))

  # Extract the variables we need for easy access
  account_alias = local.account_vars.account_alias
  account_name  = local.account_vars.account_name
  account_id    = local.account_vars.account_id
  environment   = local.account_vars.environment
  region        = local.region_vars.region

  # Use the first service from the repository metadata as the repository name
  component_repo = "terraform-infrastructure-live"

  # Truncate the relative path of the component being deployed to 256 characters to
  # comply with the AWS tag value length limit
  # Ref: https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html#tag-conventions
  component_path = substr(path_relative_to_include(), 0, 256)

}



