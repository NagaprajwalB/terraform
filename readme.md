# Terraform — Infrastructure as Code

A detailed guide to what Terraform is, how a Terraform project is structured, and the core concepts you need to work with it.

---

## Table of Contents

1. [What is Terraform](#what-is-terraform)
2. [Why Use Terraform](#why-use-terraform)
3. [Core Concepts](#core-concepts)
4. [Project Structure](#project-structure)
5. [File Types Explained](#file-types-explained)
6. [Terraform Workflow](#terraform-workflow)
7. [State Management](#state-management)
8. [Variables and Outputs](#variables-and-outputs)
9. [Modules](#modules)
10. [Providers](#providers)
11. [Common Commands](#common-commands)
12. [Best Practices](#best-practices)
13. [Example Minimal Project](#example-minimal-project)

---

## What is Terraform

Terraform is an **Infrastructure as Code (IaC)** tool created by HashiCorp. It lets you define cloud and on-prem infrastructure (servers, networks, databases, DNS records, etc.) using a declarative configuration language called **HCL (HashiCorp Configuration Language)**, instead of manually clicking through cloud consoles or writing imperative scripts.

You describe the **desired end state** of your infrastructure, and Terraform figures out how to get there — creating, updating, or destroying resources as needed.

---

## Why Use Terraform

- **Declarative** — you describe *what* you want, not the steps to get there.
- **Provider-agnostic** — works with AWS, Azure, GCP, Kubernetes, GitHub, Cloudflare, and hundreds of other providers through the same workflow.
- **Version-controlled infrastructure** — your infra definitions live in Git like any other code.
- **Plan before apply** — Terraform shows you exactly what will change before it touches anything.
- **State tracking** — Terraform keeps a record of what it manages, so it knows what to create, update, or destroy on each run.
- **Reusable** — modules let you package and share infrastructure patterns.

---

## Core Concepts

| Concept | Description |
|---|---|
| **Provider** | A plugin that lets Terraform talk to a specific platform (AWS, Azure, GCP, etc.) |
| **Resource** | A single infrastructure object Terraform manages (e.g., a VM, a bucket, a subnet) |
| **Data Source** | Read-only lookup of existing infrastructure not managed by this Terraform config |
| **Variable** | An input parameter to make configuration reusable/dynamic |
| **Output** | A value exposed after apply, useful for chaining or inspection |
| **Module** | A reusable, self-contained package of Terraform configuration |
| **State** | A file that maps your configuration to real-world resources |
| **Plan** | A preview of what actions Terraform will take |
| **Backend** | Where the state file is stored (local disk, S3, Terraform Cloud, etc.) |

---

## Project Structure

A typical, well-organized Terraform project looks like this:

```
project-root/
├── main.tf                # Primary resource definitions
├── variables.tf           # Input variable declarations
├── outputs.tf             # Output value declarations
├── providers.tf           # Provider configuration & required versions
├── versions.tf            # Terraform & provider version constraints (sometimes merged into providers.tf)
├── terraform.tfvars       # Actual variable values (often gitignored if sensitive)
├── backend.tf             # Remote state backend configuration
├── locals.tf              # Local values (computed/reused expressions)
├── data.tf                # Data source lookups
├── modules/                
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── compute/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── environments/
│   ├── dev/
│   │   └── terraform.tfvars
│   ├── staging/
│   │   └── terraform.tfvars
│   └── prod/
│       └── terraform.tfvars
├── .terraform/             # Auto-generated — providers & modules cache (gitignored)
├── .terraform.lock.hcl     # Dependency lock file (should be committed)
├── terraform.tfstate       # State file (usually stored remotely, not committed)
└── .gitignore
```

For small projects, everything might just live in a single `main.tf`. For larger, team-based projects, splitting into modules and per-environment `tfvars` is standard practice.

---

## File Types Explained

### `main.tf`
Where the primary resources are declared.
```hcl
resource "aws_instance" "web" {
  ami           = "ami-0123456789abcdef0"
  instance_type = "t2.micro"

  tags = {
    Name = "web-server"
  }
}
```

### `variables.tf`
Declares inputs so the configuration isn't hardcoded.
```hcl
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
```

### `outputs.tf`
Exposes values after apply — useful for other tools or modules to consume.
```hcl
output "instance_ip" {
  description = "Public IP of the web server"
  value       = aws_instance.web.public_ip
}
```

### `providers.tf`
Configures which providers Terraform should use and how to authenticate.
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
```

### `terraform.tfvars`
Supplies actual values for declared variables.
```hcl
instance_type = "t3.medium"
```

### `backend.tf`
Defines where the state file is stored (important for team collaboration).
```hcl
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}
```

---

## Terraform Workflow

The standard lifecycle for any Terraform project:

```
terraform init      → Initialize working directory, download providers/modules
terraform validate  → Check configuration syntax and internal consistency
terraform plan      → Preview changes Terraform will make
terraform apply     → Execute the plan and provision/update infrastructure
terraform destroy   → Tear down all managed infrastructure
```

**Typical flow:**
1. Write/modify `.tf` files.
2. Run `terraform init` (only needed once, or when providers/modules change).
3. Run `terraform plan` to review changes.
4. Run `terraform apply` to make changes live.
5. Commit your `.tf` files (and lock file) to version control.

---

## State Management

Terraform state (`terraform.tfstate`) is a JSON file that maps your configuration to real-world resource IDs. It's how Terraform knows what already exists and what needs to change.

**Key points:**
- Never edit the state file by hand.
- For team projects, use a **remote backend** (S3 + DynamoDB, Terraform Cloud, Azure Storage, GCS, etc.) so everyone works off the same state and locking prevents concurrent conflicting applies.
- Sensitive data may appear in state — treat it as a secret (encrypt at rest, restrict access).
- Useful commands: `terraform state list`, `terraform state show <resource>`, `terraform state rm <resource>`.

---

## Variables and Outputs

Variables can be supplied in multiple ways (in order of precedence, highest last):
1. Default value in `variables.tf`
2. `terraform.tfvars` file
3. `*.auto.tfvars` files
4. `-var` or `-var-file` CLI flags
5. `TF_VAR_<name>` environment variables

Outputs are how you surface values — e.g., an IP address, a DNS name, or an ARN — for use in scripts, CI/CD pipelines, or other Terraform configurations (via `terraform_remote_state`).

---

## Modules

A **module** is just a directory containing `.tf` files. Every Terraform configuration has at least one module — the **root module** (your working directory).

You can call reusable modules like this:
```hcl
module "network" {
  source = "./modules/network"

  vpc_cidr = "10.0.0.0/16"
}
```

Modules can also be pulled from:
- Local paths (`./modules/network`)
- The [Terraform Registry](https://registry.terraform.io/)
- Git repositories
- S3 buckets or HTTP URLs

Modules make configurations **reusable, testable, and composable** — e.g., a shared "vpc" module used across dev, staging, and prod.

---

## Providers

Providers are plugins that translate HCL into API calls for a specific platform. Examples:
- `hashicorp/aws`
- `hashicorp/azurerm`
- `hashicorp/google`
- `hashicorp/kubernetes`
- `cloudflare/cloudflare`

You can use multiple providers (even multiple instances of the same provider with **aliases**) in one configuration:
```hcl
provider "aws" {
  alias  = "us_west"
  region = "us-west-2"
}

resource "aws_instance" "backup" {
  provider      = aws.us_west
  ami           = "ami-xxxxxxxx"
  instance_type = "t2.micro"
}
```

---

## Common Commands

| Command | Purpose |
|---|---|
| `terraform init` | Initialize directory, download providers/modules |
| `terraform fmt` | Auto-format `.tf` files |
| `terraform validate` | Validate syntax and configuration |
| `terraform plan` | Show execution plan |
| `terraform apply` | Apply changes |
| `terraform destroy` | Destroy all managed resources |
| `terraform show` | Show current state in human-readable form |
| `terraform output` | Print output values |
| `terraform state list` | List resources tracked in state |
| `terraform import` | Bring existing infrastructure under Terraform management |
| `terraform workspace` | Manage multiple state environments (dev/stage/prod) from one config |

---

## Best Practices

- **Always run `terraform plan` before `apply`** — never apply blind, especially in production.
- **Use remote state with locking** for any team environment.
- **Pin provider and Terraform versions** in `required_version` / `required_providers` to avoid surprise breaking changes.
- **Never commit `.tfstate` or `.tfvars` files containing secrets** — use `.gitignore` and a secrets manager (Vault, AWS Secrets Manager, SSM Parameter Store) instead.
- **Commit `.terraform.lock.hcl`** — it pins exact provider versions for reproducibility.
- **Use modules** to avoid duplicating code across environments.
- **Separate environments** (dev/staging/prod) using workspaces, directories, or separate state files — don't mix them in one state.
- **Use `terraform fmt` and `terraform validate`** in CI before every merge.
- **Tag all resources** consistently (environment, owner, project) for cost tracking and cleanup.
- **Review plans in CI/CD** (e.g., via Atlantis, Terraform Cloud, or a GitHub Action) before merging infrastructure changes.

---

## Example Minimal Project

```hcl
# providers.tf
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# variables.tf
variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

# main.tf
resource "aws_s3_bucket" "example" {
  bucket = "my-example-terraform-bucket"
}

# outputs.tf
output "bucket_name" {
  value = aws_s3_bucket.example.bucket
}
```

Run it with:
```bash
terraform init
terraform plan
terraform apply
```

---

## Resources

- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [Terraform Registry](https://registry.terraform.io/)
- [HCL Syntax Reference](https://developer.hashicorp.com/terraform/language/syntax/configuration)