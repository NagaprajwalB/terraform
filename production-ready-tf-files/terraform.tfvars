# environments/prod/terraform.tfvars
# Actual values for the production environment.
# db_password is intentionally NOT set here in plain text —
# pass it via -var, TF_VAR_db_password env var, or a secrets manager integration.

aws_region    = "us-east-1"
project_name  = "my-app"
instance_type = "t3.large"
min_capacity  = 2
max_capacity  = 6
vpc_cidr      = "10.10.0.0/16"
