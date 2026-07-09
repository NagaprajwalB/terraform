# providers.tf
# Configures each provider Terraform needs to talk to (AWS, Azure, GCP, etc.)
# and how to authenticate/connect to it.

provider "aws" {
  region = "us-east-1"
}

# A second, aliased instance of the same provider —
# useful for multi-region deployments.
provider "aws" {
  alias  = "us_west"
  region = "us-west-2"
}
