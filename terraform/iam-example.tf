module "example_iam_user_least_priv" {
  source         = "../modules/iam"
  user_name      = "least-privilege-user"
  policy_name    = "least-privilege-policy"
  policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["s3:GetObject"]
      Resource = "arn:aws:s3:::modular-sample-bucket/*"
    }]
  })
}

output "least_priv_user_name" {
  value = module.example_iam_user_least_priv.user_name
}
output "least_priv_user_arn" {
  value = module.example_iam_user_least_priv.user_arn
}
output "least_priv_policy_arn" {
  value = module.example_iam_user_least_priv.policy_arn
}
