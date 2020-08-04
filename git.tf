module "github_repositories" {
  source                   = "git::https://github.com/goci-io/github-repository.git?ref=tags/0.6.0"
  count                    = var.vc_type == "github" ? length(var.repositories) : 0
  repository_name          = lookup(var.repositories[count.index], "name")
  create_repository        = lookup(var.repositories[count.index], "create")
  github_organization      = var.git_organization
  create_branch_protection = true
  topics                   = ["terraform", "atlantis", "infrastructure", "goci"]
  webhooks                 = [
    {
      name   = "atlantis"
      events = ["issue_comment", "pull_request"]
      url    = format("https://%s/events", var.atlantis_domain)
    }
  ]
}
