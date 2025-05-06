include {
  path = find_in_parent_folders()
}

locals {
  component_create  = true
  component_name    = "cloudstack/vpc/simple"
  component_version = "0.0.8"
  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
}


# Indicate the input values to use for the variables of the module.
inputs = {

  name         = "vpc-sp-east-1"
  cidr         = "10.0.0.0/16"
  vpc_offering = "Default VPC Offering"
  zone         = "zone-1"
}
