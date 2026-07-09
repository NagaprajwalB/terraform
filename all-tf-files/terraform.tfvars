# terraform.tfvars
# Actual values assigned to the variables declared in variables.tf.
# Auto-loaded by Terraform without needing -var-file.
# Should NOT contain secrets in plain text — use env vars or a secrets manager for those.

project_name  = "my-app"
instance_type = "t3.micro"
environment   = "dev"
