# providers.tf
# In production, pin versions tightly (not "~>") to avoid
# an unexpected provider update changing behavior mid-deploy.

terraform {
  required_version = "= 1.9.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.60.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = "production"
      ManagedBy   = "terraform"
      Project     = var.project_name
    }
  }
}
