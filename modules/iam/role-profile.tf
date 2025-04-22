# IAM Role and Instance Profile for EC2

variable "ec2_role_name" {
  description = "The name of the IAM role for EC2."
  type        = string
  default     = "ec2-sample-role"
}

variable "ec2_instance_profile_name" {
  description = "The name of the IAM instance profile for EC2."
  type        = string
  default     = "ec2-sample-profile"
}

variable "ec2_role_policy_document" {
  description = "Policy document for the EC2 role."
  type        = string
  default     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": "*"
    }
  ]
}
EOF
}


# The EC2 IAM role, policy, and instance profile resources have been commented out to avoid duplicate creation.
# These are now managed inline in terraform/ec2-example.tf for demonstration and modularity purposes.

# resource "aws_iam_role" "ec2" {
#   name = var.ec2_role_name
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Effect = "Allow"
#       Principal = { Service = "ec2.amazonaws.com" }
#       Action = "sts:AssumeRole"
#     }]
#   })
# }
#
# resource "aws_iam_role_policy" "ec2" {
#   name   = "${var.ec2_role_name}-policy"
#   role   = aws_iam_role.ec2.id
#   policy = var.ec2_role_policy_document
# }
#
# resource "aws_iam_instance_profile" "ec2" {
#   name = var.ec2_instance_profile_name
#   role = aws_iam_role.ec2.name
# }
#
# output "ec2_role_name" {
#   value = aws_iam_role.ec2.name
# }
# output "ec2_instance_profile_name" {
#   value = aws_iam_instance_profile.ec2.name
# }
