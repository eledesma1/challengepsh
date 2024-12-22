resource "aws_secretsmanager_secret" "rds_credentials" {
  name        = var.secret_name
  description = var.secret_description
}

resource "aws_secretsmanager_secret_version" "rds_credentials_version" {
  secret_id     = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    username = var.rds_username
    password = var.rds_password
  })
}