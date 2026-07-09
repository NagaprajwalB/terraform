# modules/network/main.tf
# A module is just a directory of .tf files, called from a root
# or another module via a `module` block. Same file types apply
# inside: main.tf, variables.tf, outputs.tf, etc.

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.this.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, 0)
}
