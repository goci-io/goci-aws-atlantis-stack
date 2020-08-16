output "webhook_url" {
  value = local.atlantis_webhook_url
}

output "webhook_secret" {
  sensitive = true
  value     = random_password.secret.result
}

output "iam_role_arn" {
  value = module.server.iam_role_arn
}
