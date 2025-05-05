include {
  path = find_in_parent_folders()
}

locals {
  component_create  = true
  component_name    = "cloudstack/vpc/simple"
  component_version = "0.0.1"
  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
}


# Indicate the input values to use for the variables of the module.
inputs = {

  name = "vpc-sp-east-1"
  cidr = "10.0.0.0/16"

  key_pair_pubkey = file(find_in_parent_folders("key_pair.txt"))

  allow_cidr_blocks = [
    {
      description = "Production - sp-east-1"
      cidr_block  = "10.128.0.0/11"
    },
    {
      description = "Production - sp-east-2"
      cidr_block  = "10.64.0.0/11"
    },
  ]

  tags = local.service_vars.tags

}
