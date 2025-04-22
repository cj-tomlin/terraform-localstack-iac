variable "user_name" {
  description = "The name of the IAM user to create."
  type        = string
}

variable "policy_name" {
  description = "The name of the IAM policy to create."
  type        = string
  default     = null
}

variable "policy_document" {
  description = "The JSON policy document to attach to the user."
  type        = string
  default     = null
}
