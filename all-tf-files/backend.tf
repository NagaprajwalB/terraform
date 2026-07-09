# backend.tf
# Defines where the state file lives. Remote backends (S3, Terraform Cloud,
# Azure Storage, GCS) enable team collaboration and state locking.

terraform {
  backend "s3" {
    bucket         = "my-company-terraform-state"
    key            = "app/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
