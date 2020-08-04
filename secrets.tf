# Webhook Secret
resource "random_integer" "pw_length" {
  min = 21
  max = 36
}

resource "random_password" "secret" {
  length           = random_integer.pw_length.result
  special          = true
  override_special = "_-=%@$!?#"
}
