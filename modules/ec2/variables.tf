variable "instance_name" {
  description = "The name tag for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "The AMI ID to use for the instance."
  type        = string
  default     = "ami-12345678" # Dummy value for LocalStack
}

variable "iam_instance_profile" {
  description = "The name of the IAM instance profile to associate with the EC2 instance."
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with the EC2 instance."
  type        = list(string)
  default     = []
}
