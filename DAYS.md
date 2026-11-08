# Terraform AWS Platform Lab — Engineering Progress Log

## Day 01 — Repository Foundation
- **Objective:** Organize repository, establish naming, and fix dependency locking.
- **Changes:** Renamed repo to `terraform-aws-platform-lab`. Replaced README. Updated `.gitignore` to track `.terraform.lock.hcl`.
- **Validation:** `terraform init`, `terraform validate`.
- **Evidence:** Commit `d04e5ce` (or whichever was the first init commit).
- **Outcome:** Clean foundation with reproducible provider lock.

## Day 02 — Parameterization
- **Objective:** Move hardcoded values into variables for reusability.
- **Changes:** Created `variables.tf`, `outputs.tf`, and `terraform.tfvars.example`. Updated `main.tf` to use `var.project_name`, `var.aws_region`, and CIDR variables.
- **Validation:** `terraform fmt -recursive`, `terraform validate`, `terraform plan`.
- **Evidence:** Plan output showed `15 to add, 0 to change, 0 to destroy`.
- **Outcome:** Infrastructure is now reusable across environments.

## Day 03 — Network Security & Isolation
- **Objective:** Replace unrestricted security groups with least-privilege rules.
- **Changes:** Created `security_groups.tf` and `security_group_rules.tf`. Removed inline security groups from `main.tf`. Implemented explicit traffic matrix (ALB -> App -> DB). Decided to keep private subnets isolated (no NAT).
- **Validation:** `terraform fmt`, `terraform validate`, `terraform plan`.
- **Evidence:** Plan output showed `21 to add, 0 to change, 0 to destroy`.
- **Outcome:** Configuration is validated. **Pending:** Runtime apply against LocalStack.

## Day 04 — LocalStack Apply & Verification
- **Objective:** Prove the infrastructure can actually be created, not just planned.
- **Changes:** Pending.
- **Validation:** Pending.
- **Evidence:** Pending.
- **Outcome:** Pending.