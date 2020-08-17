provider "github" {
  version      = "~> 2.9"
  token        = var.git_token
  organization = var.git_organization
}

resource "github_repository" "repo" {
  count                  = var.git_type == "github" ? length(local.create_repositories) : 0
  name                   = lookup(local.create_repositories[count.index], "name")
  private                = lookup(local.create_repositories[count.index], "private", true)
  description            = "Terraform Infrastructure Repository for ${var.namespace} using Atlantis"
  delete_branch_on_merge = true
  default_branch         = "master"
  topics                 = ["atlantis", "terraform", "infrastructure", "goci"]
  homepage_url           = format("https://%s", module.server.atlantis_domain)
}

resource "github_branch_protection" "master" {
  count          = var.git_type == "github" ? length(local.branch_protections) : 0
  repository     = lookup(local.branch_protections[count.index], "name")
  branch         = "master"
  enforce_admins = true

  dynamic "required_pull_request_reviews" {
    for_each = contains(var.apply_requirements, "approved") ? [1] : []

    content {
      dismiss_stale_reviews = true
    }
  }

  required_status_checks {
    strict   = true
    contexts = ["atlantis/plan"]
  }
}

resource "github_repository_webhook" "webhook" {
  count      = var.git_type == "github" ? length(var.repositories) : 0
  repository = lookup(var.repositories[count.index], "name")
  events     = ["issue_comment", "pull_request"]

  configuration {
    url          = local.atlantis_webhook_url
    secret       = random_password.secret.result
    content_type = "json"
    insecure_ssl = false
  }
}
