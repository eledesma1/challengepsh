output "secret_id" {
  value       = aws_secretsmanager_secret.rds_credentials.id
}

output "secret_string" {
  value = jsonencode({
    username = var.rds_username
    password = var.rds_password
  })
  sensitive = true
}