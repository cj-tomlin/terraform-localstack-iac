module "example_s3_bucket" {
  source       = "../modules/s3"
  bucket_name  = "modular-sample-bucket"
  force_destroy = true
}

output "example_s3_bucket_id" {
  value = module.example_s3_bucket.bucket_id
}
output "example_s3_bucket_arn" {
  value = module.example_s3_bucket.bucket_arn
}
