variable "aws_region" {
  default     = "eu-central-1"
  description = "AWS Region to be used for Atlantis"
}

variable "aws_partition" {
  default     = "aws"
  description = "AWS Partition to use to build the Assume Role ARN"
}

variable "aws_account_id" {
  description = "AWS Account ID to use to build the Assume Role ARN"
}

variable "aws_assume_role_name" {
  description = "Name of a Role to assume"
}

variable "aws_sts_external_id" {
  default     = ""
  description = "External ID to avoid Confused Deputy Problem"
}

variable "aws_identity_account_id" {
  description = "AWS Account ID with a Role to create a Trust Relationship with"
}

variable "aws_trusted_role_name" {
  description = "Name of a Role to create a Trust Relationship with"
}

variable "aws_server_role_policies" {
  type        = list(any)
  description = "List of Policies to grant Permissions to the Server Role. By default the Server only has Access to the State Bucket and Lock Table."
}

variable "cluster_fqdn" {
  description = "Domain under which Atlantis will create its Ingress"
}

variable "k8s_namespace" {
  description = "Kubernetes Namespace to deploy the Helm Release into"
}

variable "namespace" {
  description = "Organization Namespace or Prefix"
}

variable "region" {
  description = "Custom Region Names to use for Labels and Naming"
}

variable "tf_state_bucket" {
  description = "An AWS S3 Bucket containing Terraform State imported by this Module"
}

variable "dns_module_state" {
  description = "Reference to an existing DNS Module State"
}

variable "git_host" {
  default     = "github.com"
  description = "Host to the Git Platform"
}

variable "git_type" {
  default     = "github"
  description = "Supported values are github, gitlab or bitbucket"
}

variable "git_token" {
  description = "Token to be used for Atlantis and to generate Repositories and Webhooks"
}

variable "git_organization" {
  description = "Organization or Group to allow Webhooks from and create Resources in"
}

variable "repositories" {
  type        = list(object({ name = string, create = bool, private = bool }))
  description = "List of Repositories and additional Repository Configuration"
}

variable "apply_requirements" {
  type        = list(string)
  default     = ["mergable", "approved"]
  description = "Requirements which must be met before allowing atlantis apply"
}
