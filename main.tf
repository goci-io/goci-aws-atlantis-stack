locals {
  repository_names = [for repo in var.repositories :
    repo.name
  ]

  create_repositories = [for repo in var.repositories :
    repo
    if repo.create
  ]

  branch_protections = [for repo in var.repositories :
    repo
    if repo.branch_protection
  ]

  atlantis_webhook_url = format("https://%s/events", module.atlantis_server.atlantis_domain)
}

module "atlantis_server" {
  source                        = "git::https://github.com/goci-io/aws-atlantis-helm.git?ref=tags/0.2.1"
  namespace                     = var.namespace
  stage                         = "managed"
  name                          = var.name
  region                        = var.region
  aws_region                    = var.aws_region
  repositories                  = local.repository_names
  k8s_namespace                 = var.k8s_namespace
  vc_host                       = var.git_host
  vc_type                       = var.git_type
  organization                  = var.git_organization
  encrypted_token               = var.git_token
  encrypted_user                = "goci-atlantis-bot"
  encrypted_secret              = random_password.secret.result
  server_role_trusted_arns      = [format("arn:aws:iam::%s:role/%s", var.aws_identity_account_id, var.aws_trusted_role_name)]
  server_role_policy_statements = var.aws_server_role_policies
  create_server_role            = true
  configure_kiam                = true
  configure_nginx               = true
  configure_cert_manager        = true
  cert_manager_issuer_name      = data.terraform_remote_state.dns_module.outputs.issuer_name
  cluster_fqdn                  = data.terraform_remote_state.dns_module.outputs.domain_name
  helm_values_root              = abspath(path.module)

  providers = {
    aws = aws.tenant
  }
}
