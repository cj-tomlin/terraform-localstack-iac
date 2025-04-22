# Subnet Module Scaffold for LocalStack/Terraform

variable "name" {
  description = "Name of the subnet."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to associate with the subnet."
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the subnet."
  type        = string
  default     = "10.0.1.0/24"
}

resource "aws_subnet" "this" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block
  tags = {
    Name = var.name
  }
}

output "subnet_id" {
  value = aws_subnet.this.id
}
