# S3 Bucket Module for LocalStack/Terraform

resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
}
