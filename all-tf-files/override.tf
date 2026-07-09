# override.tf
# Files named override.tf or *_override.tf are loaded LAST and merge
# on top of earlier definitions, overriding specific arguments.
# Rarely used in normal projects — mostly for testing/local overrides.
# WARNING: makes configuration harder to reason about; use sparingly.

resource "aws_instance" "web" {
  instance_type = "t3.nano"   # overrides the value set in main.tf, for local testing
}
