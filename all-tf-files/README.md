# All Terraform File Types — Reference

Terraform doesn't enforce these filenames — it loads **every `*.tf` file** in a
directory and merges them into one configuration. The names below are strong
community conventions, not hard rules.

| File | Required? | Purpose |
|---|---|---|
| `main.tf` | Convention | Primary resource definitions |
| `variables.tf` | Convention | Declares input variables |
| `outputs.tf` | Convention | Declares output values |
| `providers.tf` | Convention | Configures providers (AWS, Azure, GCP...) |
| `versions.tf` | Convention | Pins Terraform core + provider versions |
| `backend.tf` | Convention | Configures remote state storage/locking |
| `locals.tf` | Convention | Computed/reused local values |
| `data.tf` | Convention | Read-only data source lookups |
| `terraform.tfvars` | Auto-loaded | Actual values for declared variables |
| `*.auto.tfvars` | Auto-loaded | Additional auto-loaded variable files |
| `override.tf` / `*_override.tf` | Optional | Loaded last; overrides earlier blocks |
| `.terraform.lock.hcl` | Auto-generated | Locks exact provider versions (commit this) |
| `terraform.tfstate` | Auto-generated | Current infrastructure state (don't hand-edit or commit) |

## Files in this example

```
all-tf-files-example/
├── main.tf                     # core resources: EC2 instance, S3 bucket
├── variables.tf                # input variable declarations
├── outputs.tf                  # output values (IP, bucket ARN)
├── providers.tf                # AWS provider (+ aliased second region)
├── versions.tf                 # Terraform & provider version constraints
├── backend.tf                  # S3 + DynamoDB remote state backend
├── locals.tf                   # common_tags, name_prefix
├── data.tf                     # VPC/subnet/AMI lookups
├── terraform.tfvars            # actual variable values
├── example.auto.tfvars         # extra auto-loaded variables
├── override.tf                 # demonstrates override behavior (use sparingly!)
└── modules/
    └── network/
        ├── main.tf              # VPC + subnet resources
        ├── variables.tf         # module inputs
        └── outputs.tf           # module outputs
```

## Load order

1. All root-level `*.tf` files are parsed together (order among them doesn't matter,
   *except* `override.tf` / `*_override.tf`, which is applied last).
2. `terraform.tfvars` and `*.auto.tfvars` are loaded automatically for variable values.
3. Any `module` blocks pull in the module's own files the same way, recursively.

## Not a `.tf` file, but part of every project

- **`.terraform/`** — auto-generated cache of downloaded providers/modules (gitignore it)
- **`.terraform.lock.hcl`** — dependency lock file (commit this)
- **`terraform.tfstate`** / **`terraform.tfstate.backup`** — state (use remote backend, don't commit)
