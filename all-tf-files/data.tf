# data.tf
# Data sources — read-only lookups of existing infrastructure
# NOT managed by this Terraform configuration.

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "selected" {
  vpc_id = data.aws_vpc.default.id

  filter {
    name   = "tag:Tier"
    values = ["public"]
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
