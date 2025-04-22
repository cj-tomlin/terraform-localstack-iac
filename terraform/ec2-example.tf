# Inline IAM role and instance profile for EC2 demo
resource "aws_iam_role" "ec2" {
  name = "ec2-sample-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "ec2" {
  name   = "ec2-sample-role-policy"
  role   = aws_iam_role.ec2.id
  policy = <<EOF
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

resource "aws_iam_instance_profile" "ec2" {
  name = "ec2-sample-profile"
  role = aws_iam_role.ec2.name
}

# Example: Modular Security Group usage for EC2
module "ec2_demo_security_group" {
  source = "../modules/security_group"
  name   = "modular-sample-sg"
  description = "Allow SSH for demo purposes"
  ingress = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "ec2_demo_ec2_instance" {
  source                = "../modules/ec2"
  instance_name         = "modular-sample-ec2"
  instance_type         = "t3.micro"
  ami_id                = "ami-12345678"
  iam_instance_profile  = aws_iam_instance_profile.ec2.name
  vpc_security_group_ids = [module.ec2_demo_security_group.security_group_id]
}

output "ec2_demo_instance_id" {
  description = "EC2 Instance ID"
  value = module.ec2_demo_ec2_instance.instance_id
}
output "ec2_demo_instance_arn" {
  description = "EC2 Instance ARN"
  value = module.ec2_demo_ec2_instance.instance_arn
}
output "ec2_demo_instance_public_ip" {
  description = "EC2 Instance Public IP"
  value = module.ec2_demo_ec2_instance.instance_public_ip
}
