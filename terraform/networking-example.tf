# Example: Modular Networking with VPC, Subnet, and Security Group

module "network_demo_vpc" {
  source = "../modules/vpc"
  name   = "modular-sample-vpc"
  cidr_block = "10.0.0.0/16"
}

module "network_demo_subnet" {
  source = "../modules/subnet"
  name   = "modular-sample-subnet"
  vpc_id = module.network_demo_vpc.vpc_id
  cidr_block = "10.0.1.0/24"
}

module "network_demo_security_group" {
  source = "../modules/security_group"
  name   = "modular-sample-sg"
  description = "Allow SSH for demo purposes"
  vpc_id = module.network_demo_vpc.vpc_id
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

output "network_demo_vpc_id" {
  value = module.network_demo_vpc.vpc_id
}
output "network_demo_subnet_id" {
  value = module.network_demo_subnet.subnet_id
}
output "network_demo_security_group_id" {
  value = module.network_demo_security_group.security_group_id
}
