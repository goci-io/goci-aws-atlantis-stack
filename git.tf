resource "github_branch_protection" "master" {
  count          = var.git_type == "github" ? length(var.repositories) : 0
  repository     = var.repositories[count.index]
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
  repository = var.repositories[count.index]
  events     = ["issue_comment", "pull_request"]

  configuration {
    url          = format("https://%s/events", module.server.atlantis_domain)
    secret       = random_password.secret.result
    content_type = "json"
    insecure_ssl = false
  }
}
