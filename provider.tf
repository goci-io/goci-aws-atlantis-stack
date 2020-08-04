terraform {
  #required_version = ">= 0.13.0"
  backend "s3" {}

  required_providers {
    random = "~> 2.3"
    local  = "~> 1.4"
  }
}

provider "aws" {
  version = "~> 2.50" 
}

provider "aws" {
  version = "~> 2.50"
  alias   = "tenant"
  region  = var.aws_region

  assume_role {
    role_arn    = format("arn:%s:iam::%s:role/%s", var.aws_partition, var.aws_account_id, var.aws_assume_role_name)
    external_id = var.aws_sts_external_id
  }
}

data "terraform_remote_state" "dns_module" {
  backend = "s3"

  config = {
    bucket = var.tf_state_bucket
    key    = var.dns_module_state
  }
}
