# Example: Launch EC2 Instance in Custom VPC, Subnet, and Security Group

module "ec2_network_demo_vpc" {
  source = "../modules/vpc"
  name   = "custom-vpc"
  cidr_block = "10.10.0.0/16"
}

module "ec2_network_demo_subnet" {
  source = "../modules/subnet"
  name   = "custom-subnet"
  vpc_id = module.ec2_network_demo_vpc.vpc_id
  cidr_block = "10.10.1.0/24"
}

module "ec2_network_demo_security_group" {
  source = "../modules/security_group"
  name   = "custom-sg"
  description = "Allow SSH for demo purposes"
  vpc_id = module.ec2_network_demo_vpc.vpc_id
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

resource "aws_iam_role" "ec2_network_demo_role" {
  name = "custom-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "ec2_network_demo_policy" {
  name   = "custom-ec2-role-policy"
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

resource "aws_iam_instance_profile" "ec2_network_demo_profile" {
  name = "custom-ec2-profile"
  role = aws_iam_role.ec2.name
}

module "ec2_network_demo_ec2_instance" {
  source                = "../modules/ec2"
  instance_name         = "custom-networked-ec2"
  instance_type         = "t3.micro"
  ami_id                = "ami-12345678"
  iam_instance_profile  = aws_iam_instance_profile.ec2_network_demo_profile.name
  vpc_security_group_ids = [module.ec2_network_demo_security_group.security_group_id]
}

output "ec2_network_demo_vpc_id" {
  value = module.ec2_network_demo_vpc.vpc_id
}
output "ec2_network_demo_subnet_id" {
  value = module.ec2_network_demo_subnet.subnet_id
}
output "ec2_network_demo_security_group_id" {
  value = module.ec2_network_demo_security_group.security_group_id
}
output "ec2_network_demo_instance_id" {
  value = module.ec2_network_demo_ec2_instance.instance_id
}
output "ec2_network_demo_instance_public_ip" {
  value = module.ec2_network_demo_ec2_instance.instance_public_ip
}
