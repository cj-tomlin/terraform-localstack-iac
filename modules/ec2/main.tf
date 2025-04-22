# EC2 Module for LocalStack/Terraform

resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type

  # Attach IAM instance profile if provided
  iam_instance_profile = var.iam_instance_profile

  # Attach security groups if provided
  vpc_security_group_ids = var.vpc_security_group_ids

  tags = {
    Name = var.instance_name
  }
}
