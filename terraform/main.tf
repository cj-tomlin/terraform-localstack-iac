terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  access_key = "test"
  secret_key = "test"
  region     = "eu-central-1"

  s3_use_path_style           = true
  skip_requesting_account_id  = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true

  endpoints {
    ec2            = "http://localhost:4566"
    iam            = "http://localhost:4566"
    s3             = "http://localhost:4566"
  }
}

resource "aws_s3_bucket" "sample" {
  bucket = "sample-bucket"
}