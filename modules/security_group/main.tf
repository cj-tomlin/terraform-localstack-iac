# Security Group Module Scaffold for LocalStack/Terraform

variable "name" {
  description = "Name of the security group."
  type        = string
}

variable "description" {
  description = "Description of the security group."
  type        = string
  default     = "Managed by Terraform"
}

variable "vpc_id" {
  description = "VPC ID to associate with the security group. (Not required for LocalStack, but included for AWS compatibility.)"
  type        = string
  default     = null
}

# Ingress/Egress rules can be extended as needed
variable "ingress" {
  description = "List of ingress rules."
  type        = list(any)
  default     = []
}

variable "egress" {
  description = "List of egress rules."
  type        = list(any)
  default     = []
}

resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

output "security_group_id" {
  value = aws_security_group.this.id
}
