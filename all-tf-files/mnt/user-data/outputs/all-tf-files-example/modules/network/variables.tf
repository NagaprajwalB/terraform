# modules/network/variables.tf
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "env" {
  description = "Environment name, used for tagging"
  type        = string
}
