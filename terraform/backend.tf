# Configure local backend for Terraform state (LocalStack only)
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}