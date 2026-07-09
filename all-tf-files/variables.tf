# variables.tf
# Declares every input parameter the configuration accepts.
# Values are supplied via terraform.tfvars, CLI flags, or env vars —
# never hardcoded here.

variable "project_name" {
  description = "Name used as a prefix for resources"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}
