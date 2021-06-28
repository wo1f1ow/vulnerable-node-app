# Terraform configurations must declare which providers they require so that Terraform can install and use them.
provider "aws" {
  region = var.aws_region
  profile = var.terraform_profile
}
