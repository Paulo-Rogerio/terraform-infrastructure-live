terraform {
  source = "${local.blueprint_repository}//${local.component_name}?ref=${local.component_version_type}"
}

locals {  
  common_dir = format("%s/_common", get_repo_root())

  repo_root  = run_cmd("--terragrunt-quiet", "git", "rev-parse", "--show-toplevel")

  blueprint_repository = "git::https://github.com/Paulo-Rogerio/terraform-blueprints.git"

  tmp_component_version_parts = split(".", local.component_version)
  component_version_year      = try(tonumber(element(local.tmp_component_version_parts, 0)), null)
  component_version_month     = try(tonumber(element(local.tmp_component_version_parts, 1)), null)
  component_version_patch     = try(tonumber(element(local.tmp_component_version_parts, 2)), null)  

  # Automatically load account and region-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl")).locals

  # Child component values
  component_create       = tobool(run_cmd("--terragrunt-quiet", "${local.repo_root}/_bin/read-component-value.sh", "component_create", "${local.repo_root}/${path_relative_to_include()}/"))
  component_destroy      = tobool(run_cmd("--terragrunt-quiet", "${local.repo_root}/_bin/read-component-value.sh", "component_destroy", "${local.repo_root}/${path_relative_to_include()}/"))
  component_name         = tostring(run_cmd("--terragrunt-quiet", "${local.repo_root}/_bin/read-component-value.sh", "component_name", "${local.repo_root}/${path_relative_to_include()}/"))
  component_version      = tostring(run_cmd("--terragrunt-quiet", "${local.repo_root}/_bin/read-component-value.sh", "component_version", "${local.repo_root}/${path_relative_to_include()}/"))
  component_version_type = can(regex("^[0-9]+\\.[0-9]+\\.[0-9]+$", local.component_version)) ? "v${local.component_version}" : "${local.component_version}"

  # Extract the variables we need for easy access
  account_alias = local.account_vars.account_alias
  account_name  = local.account_vars.account_name
  account_id    = local.account_vars.account_id
  environment   = local.account_vars.environment
  region        = local.region_vars.region

  # Use the first service from the repository metadata as the repository name
  #component_repo = "terraform-infrastructure-live"
  #component_path = substr(path_relative_to_include(), 0, 256)

  api_url    = local.account_vars.api_url
  api_key    = local.account_vars.api_key
  secret_key = local.account_vars.secret_key
}

generate "cloudstack_provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = templatefile(
    "${get_repo_root()}/_templates/provider.tf.tftpl",
    {
      api_url    = local.api_url,
      api_key    = local.api_key,
      secret_key = local.secret_key
    }
  )
}