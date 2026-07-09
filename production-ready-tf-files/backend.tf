# backend.tf
# Defines WHERE the production state file is stored.
# Remote state + locking is mandatory in production so multiple engineers
# never apply concurrently and overwrite each other's changes.

terraform {
  backend "s3" {
    bucket         = "my-company-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"   # enables state locking
    encrypt        = true                # encrypt state at rest
  }
}
