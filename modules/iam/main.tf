# IAM Module for LocalStack/Terraform

resource "aws_iam_user" "this" {
  name = var.user_name
}

resource "aws_iam_policy" "this" {
  count  = var.policy_document != null && var.policy_name != null ? 1 : 0
  name   = var.policy_name
  policy = var.policy_document
}

resource "aws_iam_user_policy_attachment" "this" {
  count      = var.policy_document != null && var.policy_name != null ? 1 : 0
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.this[0].arn
}
