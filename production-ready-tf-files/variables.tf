# variables.tf
# Declares every input the production config needs.
# Actual values live in environments/prod/terraform.tfvars — never here.

variable "aws_region" {
  description = "AWS region for production resources"
  type        = string
}

variable "project_name" {
  description = "Project name used for tagging and naming"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for production servers"
  type        = string
  default     = "t3.large"
}

variable "min_capacity" {
  description = "Minimum number of instances in the ASG"
  type        = number
  default     = 2
}

variable "max_capacity" {
  description = "Maximum number of instances in the ASG"
  type        = number
  default     = 6
}

variable "vpc_cidr" {
  description = "CIDR block for the production VPC"
  type        = string
}

variable "db_password" {
  description = "Production database password (never store in tfvars in plain text — pull from Secrets Manager/SSM)"
  type        = string
  sensitive   = true
}
