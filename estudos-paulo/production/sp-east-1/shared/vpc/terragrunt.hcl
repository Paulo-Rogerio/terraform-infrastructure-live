prevent_destroy = true

include {
  path = find_in_parent_folders()
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
  cidr                     = "10.0.0.0/16"
  vpc_offering             = "Default VPC Offering"
  zone                     = "sp-east-1a"
  subnets                  = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  default_network_offering = "NAT for VPC"
  subnet_names             = ["nw-1", "nw-2", "nw-3"]
}


