# locals.tf
# Local values — computed expressions reused across the config
# without repeating logic or re-declaring as a variable.

locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }

  name_prefix = "${var.project_name}-${var.environment}"
}
