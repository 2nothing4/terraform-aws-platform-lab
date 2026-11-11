<div align="center">

# 🏗️ Terraform AWS Platform Lab

**A hands-on Infrastructure-as-Code project focused on designing and validating a secure AWS network foundation.**

<p>
  <img src="https://img.shields.io/badge/Terraform-7B42BC?logo=terraform&logoColor=white" alt="Terraform" />
  <img src="https://img.shields.io/badge/AWS-FF9900?logo=amazonaws&logoColor=white" alt="AWS" />
  <img src="https://img.shields.io/badge/LocalStack-4B5563?logo=localstack&logoColor=white" alt="LocalStack" />
  <img src="https://img.shields.io/badge/Status-Early_Development-orange" alt="Project Status" />
</p>

*An independent infrastructure engineering project by [Ziad](https://github.com/ziadchabane).*

</div>

---

> [!IMPORTANT]
> **Project Status:** Early Development  
> **Validation Environment:** LocalStack  
> **Real AWS Deployment:** Not deployed
>
> This repository represents infrastructure-as-code development and local validation, not a production AWS deployment.

## 📑 Table of Contents

- [Objectives](#-objectives)
- [Current Implementation](#-current-implementation)
- [Security Architecture](#-security-architecture)
- [Target Architecture](#-target-architecture)
- [Technology Stack](#-technology-stack)
- [Local Development](#-local-development)
- [State and Dependency Management](#-state-and-dependency-management)
- [Validation Boundaries](#-validation-boundaries)
- [Planned Milestones](#-planned-milestones)

---

## 🎯 Objectives

This project focuses on building a secure, configurable, and maintainable AWS network foundation using Terraform.

The main objectives are:

- Build a configurable AWS VPC foundation.
- Separate public and private network tiers.
- Define explicit routing and security boundaries.
- Apply least-privilege network access principles.
- Develop reusable and maintainable Terraform configuration.
- Use input variables to avoid unnecessary hardcoding.
- Export useful infrastructure information through Terraform outputs.
- Validate infrastructure changes before deployment.
- Introduce automated formatting, validation, and security checks.
- Practice infrastructure engineering through incremental, verifiable changes.

## 🏗️ Current Implementation

The initial Terraform configuration declares the following infrastructure resources:

| Component | Current Configuration |
| :--- | :--- |
| **VPC** | `10.0.0.0/16` with DNS support and hostnames enabled |
| **Public Subnets** | Two subnets across two Availability Zones |
| **Private Subnets** | Two subnets across two Availability Zones |
| **Internet Gateway** | Attached to the VPC |
| **Public Route Table** | Default route through the Internet Gateway |
| **Private Route Table** | Separate route table without a default internet route |
| **Security Groups** | ALB, Application, and Database security-group definitions |
| **Input Variables** | Region, CIDRs, Availability Zones, and project name |
| **Outputs** | VPC ID, public subnet IDs, and private subnet IDs |

### Infrastructure Scope

The current project focuses on the network foundation rather than deploying a complete application platform.

The following components are not currently deployed:

- Application Load Balancer.
- Application compute instances or containers.
- Amazon RDS database.
- Amazon EKS cluster.
- Production monitoring infrastructure.

> [!NOTE]
> These are infrastructure resource definitions. Defining a security group for an ALB does not create an actual Application Load Balancer. Likewise, defining network infrastructure does not automatically deploy application or database workloads.

The configuration is being parameterized to make network settings easier to maintain and reuse rather than hardcoding every value directly into resource definitions.

## 🔐 Security Architecture

The intended security model follows the principle of least privilege.

The design separates network responsibilities between three security groups:

- **ALB Security Group:** Handles public HTTP/HTTPS ingress.
- **Application Security Group:** Accepts application traffic from the ALB and communicates with the database.
- **Database Security Group:** Accepts PostgreSQL traffic only from the application tier.

### Traffic Matrix — Intended Design

| Security Group | Direction | Allowed Traffic | Destination / Source |
| :--- | :--- | :--- | :--- |
| **ALB** | Ingress | TCP 80, 443 | Internet (`0.0.0.0/0`) |
| **ALB** | Egress | TCP 8080 | Application SG |
| **Application** | Ingress | TCP 8080 | ALB SG |
| **Application** | Egress | TCP 5432 | Database SG |
| **Database** | Ingress | TCP 5432 | Application SG |
| **Database** | Egress | None explicitly required | Stateful return traffic is permitted |

> [!IMPORTANT]
> This matrix describes the intended traffic policy. The actual Terraform security-group rules must be inspected and validated before treating every rule as implemented.

### Security-Group Rule Management

The preferred implementation uses standalone Terraform resources:

- `aws_vpc_security_group_ingress_rule`
- `aws_vpc_security_group_egress_rule`

This provides granular control over individual rules and avoids mixing inline security-group rules with standalone rule resources.

The intended benefits include:

- Explicit ingress and egress definitions.
- Easier security-rule auditing.
- Clearer relationships between application tiers.
- Reduced risk of accidentally allowing unnecessary traffic.
- More maintainable Terraform resource definitions.

### Private Subnet Egress Strategy

The initial network design intentionally avoids a NAT Gateway.

Private subnets have no default internet route. This reduces infrastructure cost and limits unnecessary outbound connectivity.

If application workloads later require outbound internet access, the architecture will need an explicit egress design, potentially involving:

- A NAT Gateway.
- Carefully scoped outbound security-group rules.
- Separate routing strategies for application and database tiers.

> [!WARNING]
> An isolated database tier and an application tier may have different connectivity requirements. The final architecture should distinguish private application subnets from isolated private data subnets rather than assuming both tiers need identical routing.

## 🚀 Target Architecture

The intended architecture will evolve toward a more complete AWS network foundation.

### Network Design

- A VPC distributed across two Availability Zones.
- Public subnets for internet-facing ingress.
- Private application subnets.
- Isolated private data subnets.
- Separate route tables where appropriate.
- An Internet Gateway for public network connectivity.
- A deliberate private-subnet egress design.

### Security Design

- Explicit security-group relationships.
- Least-privilege ingress and egress rules.
- Application access restricted to the appropriate ALB security group.
- Database access restricted to the application security group.
- No unnecessary public exposure of private workloads.
- Clear separation between application and database network tiers.

### Infrastructure Engineering

- Reusable Terraform configuration.
- Clear input variables and outputs.
- Consistent resource naming.
- Controlled Terraform state management.
- Infrastructure validation before applying changes.
- Automated code-quality and security checks.

The goal is to establish a secure and maintainable network foundation before introducing application and database workloads.

## 🛠️ Technology Stack

### Currently Used

| Technology | Purpose |
| :--- | :--- |
| **Terraform** | Infrastructure as Code |
| **HashiCorp AWS Provider** | AWS resource definitions |
| **LocalStack** | Local AWS API simulation |
| **Docker** | Local development environment |
| **Git** | Version control |
| **GitHub** | Source-code hosting and project history |

### Planned Tooling

| Technology | Purpose |
| :--- | :--- |
| **GitHub Actions** | Automated infrastructure validation |
| **TFLint** | Terraform linting |
| **Checkov** | Infrastructure-as-code security checks |

These tools will be introduced incrementally as the project develops.

## 💻 Local Development

### Prerequisites

Before working with this repository, install:

- Terraform CLI.
- Docker.
- Git.

You should also have a basic understanding of Terraform configuration, AWS networking, and command-line operations.

### 1. Clone the Repository

```bash
git clone https://github.com/ziadchabane/terraform-aws-platform-lab.git
cd terraform-aws-platform-lab
```

### 2. Start LocalStack

Start LocalStack separately from Terraform:

```bash
docker run --rm -d \
  --name localstack \
  -p 4566:4566 \
  -e SERVICES=ec2 \
  localstack/localstack:2.3
```

Verify that the container is running:

```bash
docker ps
```

The Terraform AWS provider is configured to target the LocalStack EC2 endpoint:

```text
http://localhost:4566
```

Make sure LocalStack is running before attempting local infrastructure operations.

### 3. Initialize Terraform

Run from the repository root:

```bash
terraform init
```

This initializes the working directory and downloads the required provider plugins.

### 4. Format the Configuration

```bash
terraform fmt -recursive
```

This formats Terraform files consistently throughout the project.

### 5. Validate the Configuration

```bash
terraform validate
```

This checks Terraform configuration syntax and internal consistency.

### 6. Generate an Execution Plan

```bash
terraform plan -var-file="terraform.tfvars.example"
```

Review the execution plan carefully before making infrastructure changes.

A Terraform plan describes the changes Terraform intends to make. It does not prove that resources have been created successfully.

### 7. Review the Terraform State

```bash
terraform workspace show
terraform state list
```

These commands help inspect the active workspace and resources currently tracked by Terraform state.

> [!WARNING]
> Before applying changes, verify the active provider configuration and confirm that Terraform is targeting LocalStack rather than real AWS. Do not apply changes to real AWS as part of this project's current validation workflow.

## 🔐 State and Dependency Management

Terraform state is essential for tracking the relationship between the configuration and managed infrastructure.

This project follows these practices:

- Local Terraform state files (`terraform.tfstate`) are excluded from Git.
- The `.terraform/` working directory is excluded from version control.
- The `.terraform.lock.hcl` dependency lock file is committed to preserve provider selections.
- Real credentials and secret-filled variable files must never be committed.
- Terraform state and plan files should be treated as potentially sensitive artifacts.
- Infrastructure changes should be reviewed through execution plans before applying.

### Git Ignore Policy

The repository excludes local and sensitive Terraform artifacts, including:

```text
.terraform/
*.tfstate
*.tfstate.*
*.tfplan
*.tfvars
!terraform.tfvars.example
crash.log
```

The dependency lock file is intentionally tracked:

```text
.terraform.lock.hcl
```

This ensures consistent provider selections across environments.

> [!NOTE]
> The `.gitignore` example describes the intended policy. Check the actual repository configuration before replacing existing ignore rules.

## 🚦 Validation Boundaries

LocalStack provides an AWS-compatible API environment for local infrastructure development and testing.

The project uses LocalStack to develop and validate Terraform configurations without requiring a real AWS deployment.

### What Terraform Validation Proves

| Validation | What It Checks |
| :--- | :--- |
| `terraform fmt` | Terraform formatting consistency |
| `terraform validate` | Configuration syntax and internal consistency |
| `terraform plan` | Proposed infrastructure changes |
| LocalStack testing | Behavior against supported local AWS API implementations |

### What Validation Does Not Prove

> [!CAUTION]
> A successful Terraform validation or LocalStack test is not equivalent to deploying and validating infrastructure in real AWS.

Local validation does not independently prove:

- Real AWS networking behavior.
- Production service availability and compatibility.
- IAM behavior and permissions in a real AWS account.
- AWS quotas and regional constraints.
- Actual resource deployment and operational behavior.
- Infrastructure costs in a production environment.
- Production readiness or security certification.

## 📍 Planned Milestones

The project is being developed incrementally, with each milestone focused on a specific infrastructure engineering objective.

### Foundation

- Rename and organize the Terraform repository.
- Refactor the initial configuration into clear Terraform files.
- Parameterize the AWS region, CIDR ranges, Availability Zones, and project name.
- Add infrastructure outputs.
- Review and verify the complete network foundation.

### Network Security

- Implement and verify least-privilege security-group rules.
- Verify private subnet routing and egress behavior.
- Review application-to-database traffic restrictions.
- Document security-group dependencies.
- Verify that no unintended public access is allowed.

### Validation and Automation

- Establish reproducible LocalStack validation.
- Add Terraform formatting checks.
- Add Terraform validation to GitHub Actions.
- Integrate TFLint.
- Integrate Checkov.
- Document validation results and known limitations.

### Future Infrastructure

- Design separate application and database subnet tiers.
- Evaluate an appropriate private application egress strategy.
- Develop the application-tier architecture.
- Develop the data-tier architecture.
- Evaluate future load-balancing and compute requirements.

### Documentation and Maintenance

- Document architecture decisions.
- Maintain accurate infrastructure diagrams.
- Keep implementation status synchronized with actual Terraform resources.
- Record validation evidence for completed milestones.