output "access_key" {
  description = "Access Key ID for 3scale user"
  value       = aws_iam_access_key.three_scale.id
}

output "secret_key" {
  description = "Secret Key ID for 3scale user"
  value       = aws_iam_access_key.three_scale.secret
  sensitive   = true
}
