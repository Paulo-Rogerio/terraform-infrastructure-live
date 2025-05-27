prevent_destroy = true

include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = false
  component_name    = "cloudstack/vpc/simple"
  component_version = "0.0.18"
  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
}


# Indicate the input values to use for the variables of the module.
inputs = {

  name                     = "vpc-sp-east-1"
  cidr                     = "10.0.0.0/18"
  vpc_offering             = "Default VPC offering"
  zone                     = "CS-SIM1 Adv Zone x86"
}


