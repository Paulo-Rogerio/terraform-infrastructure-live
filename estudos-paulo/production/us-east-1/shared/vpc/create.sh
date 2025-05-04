terraform=1.6.6
terragrunt=0.54.12

rm -f .terraform.lock.hcl
rm -rf .terragrunt-cache
TF_VAR_aws_region="us-east-1" TF_VAR_environment="production" terragrunt plan && \
TF_VAR_aws_region="us-east-1" TF_VAR_environment="production" terragrunt apply
