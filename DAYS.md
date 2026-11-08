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
- **Changes:** None (infrastructure code unchanged). Executed `terraform apply` against a fresh LocalStack container.
- **Validation:** `terraform apply -var-file="terraform.tfvars.example"` succeeded. LocalStack API logs confirmed 200 OK for all resource creations.
- **Evidence:** `Apply complete! Resources: 21 added, 0 changed, 0 destroyed.` Outputs exported (VPC ID, Subnet IDs).
- **Outcome:** The Terraform configuration is fully validated at runtime. The isolated network and least-privilege security rules successfully deployed.

## Day 05 — Terraform CI Pipeline
- **Objective:** Automate formatting, validation, and linting checks in GitHub Actions.
- **Changes:** Created `.github/workflows/terraform-ci.yml` and `.tflint.hcl`. Added `required_version = ">= 1.0.0"` to `main.tf` to satisfy TFLint rules.
- **Validation:** GitHub Actions workflow `Terraform CI #2` passed successfully (Format, Init, Validate, TFLint).
- **Evidence:** GitHub Actions green checkmark.
- **Outcome:** The repository now enforces code quality and Terraform best practices on every push to `main`.

## Day 06 — Repository Hardening
- **Objective:** Prevent broken infrastructure code from being merged.
- **Changes:** Enabled GitHub branch protection rules for `main`. Required the `Terraform CI` status check to pass before merging.
- **Validation:** Verified the rule is active in repository settings.
- **Outcome:** The CI pipeline now actively blocks merges if formatting, validation, or TFLint fails.