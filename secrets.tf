locals {
  ssh_key_file_path = abspath(local_file.private_ssh_ci_key.filename)
  public_ssh_key    = tls_private_key.ci_ssh.public_key_openssh
}

# Deploy SSH Key
resource "tls_private_key" "ci_ssh" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "local_file" "private_ssh_ci_key" {
  sensitive_content = tls_private_key.ci_ssh.private_key_pem
  filename          = "${var.persistent_directory}/.ssh/git_rsa"
  file_permission   = "0400"
}

# Webhook Secret
resource "random_integer" "pw_length" {
  min   = 21
  max   = 36
}

resource "random_password" "secret" {
  length           = random_integer.pw_length.result
  special          = true
  override_special = "_-=%@$!?#"
}
