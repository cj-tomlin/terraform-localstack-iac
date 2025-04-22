output "user_name" {
  value = aws_iam_user.this.name
}

output "user_arn" {
  value = aws_iam_user.this.arn
}

output "policy_arn" {
  value = var.policy_document != null && var.policy_name != null ? aws_iam_policy.this[0].arn : null
}
