# main.tf
# The primary file — holds the core resource declarations.
# Convention only; Terraform doesn't care about filenames,
# it reads every *.tf file in the directory and merges them.

resource "aws_instance" "web" {
  ami           = "ami-0123456789abcdef0"
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.selected.id

  tags = local.common_tags
}

resource "aws_s3_bucket" "assets" {
  bucket = "${var.project_name}-assets"
  tags   = local.common_tags
}
