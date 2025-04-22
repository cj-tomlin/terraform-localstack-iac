variable "bucket_name" {
  description = "The name of the S3 bucket to create."
  type        = string
}

variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error."
  type        = bool
  default     = false
}
