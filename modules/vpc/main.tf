# VPC Module Scaffold for LocalStack/Terraform

variable "name" {
  description = "Name of the VPC."
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  tags = {
    Name = var.name
  }
}

output "vpc_id" {
  value = aws_vpc.this.id
}
