# outputs.tf
# Values exposed after `terraform apply` — consumed by other modules,
# CI/CD pipelines, or read manually with `terraform output`.

output "instance_public_ip" {
  description = "Public IP address of the web instance"
  value       = aws_instance.web.public_ip
}

output "bucket_arn" {
  description = "ARN of the assets bucket"
  value       = aws_s3_bucket.assets.arn
}
