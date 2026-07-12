resource "aws_s3_bucket" "my_bucket" {
  bucket = "hitesh-my-demo-s3-bucket-123456"
  tags = {
    Name        = "Terraform-S3-Bucket"
    }
}
