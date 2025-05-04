include {
  path = find_in_parent_folders()
}

locals {
  component_create  = true
  component_name    = "aws/vpc/simple"
  component_version = "0.0.4"
  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
}


# Indicate the input values to use for the variables of the module.
inputs = {

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  key_pair_pubkey = file(find_in_parent_folders("key_pair.txt"))

  allow_cidr_blocks = [
    {
      description = "Production - us-east-2"
      cidr_block  = "10.128.0.0/11"
    },
    {
      description = "Production - us-east-2"
      cidr_block  = "10.64.0.0/11"
    },
  ]

  tags = local.service_vars.tags

}
