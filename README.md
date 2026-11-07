<div align="center">

# 🏗️ Terraform AWS Platform Lab

**A hands-on Infrastructure-as-Code project focused on designing and validating a secure AWS network foundation.**

<p>
  <img src="https://img.shields.io/badge/Terraform-7B42BC?logo=terraform&logoColor=white" alt="Terraform" />
  <img src="https://img.shields.io/badge/AWS-FF9900?logo=amazonaws&logoColor=white" alt="AWS" />
  <img src="https://img.shields.io/badge/LocalStack-4B5563?logo=localstack&logoColor=white" alt="LocalStack" />
  <img src="https://img.shields.io/badge/Status-Early_Development-orange" alt="Project Status" />
</p>

*An independent infrastructure engineering project by [Ziad](https://github.com/2nothing4).*

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
- [Target Architecture](#-target-architecture)
- [Technology Stack](#-technology-stack)
- [Local Development](#-local-development)
- [State and Dependency Management](#-state-and-dependency-management)
- [Validation Boundaries](#-validation-boundaries)
- [Planned Milestones](#-planned-milestones)

---

## 🎯 Objectives

- Build a configurable AWS VPC foundation.
- Separate public and private network tiers.
- Define explicit routing and security boundaries.
- Develop reusable and maintainable Terraform configuration.
- Validate infrastructure changes before deployment.
- Introduce automated formatting, validation, and security checks.

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
| **ALB Security Group** | Inbound TCP 80 and 443 |
| **Application Security Group** | Inbound TCP 8080 from the ALB security group |
| **Database Security Group** | Inbound TCP 5432 from the application security group |

> [!NOTE]
> These are infrastructure resource definitions. The current implementation does not yet create an actual Application Load Balancer, application compute resources, an RDS database, or an EKS cluster.

> [!WARNING]
> The current security groups allow outbound traffic to all destinations. Restricting egress is part of the planned security improvements.

## 🚀 Target Architecture

The intended architecture will evolve toward:

- A VPC distributed across two Availability Zones.
- Public subnets for internet-facing ingress.
- Private application subnets.
- Isolated private data subnets.
- Explicit security-group relationships and least-privilege rules.
- A deliberate private-subnet egress design.
- Reusable Terraform configuration with clear input variables and outputs.

## 🛠️ Technology Stack

**Currently used:**
- **Terraform** for Infrastructure as Code.
- **HashiCorp AWS Provider** for AWS resource definitions.
- **LocalStack** for local AWS API simulation.

**Planned tooling:**
- **GitHub Actions** for automated infrastructure validation.
- **TFLint** for Terraform linting.
- **Checkov** for infrastructure-as-code security checks.

## 💻 Local Development

### Prerequisites

- Terraform CLI
- Docker
- Git

### 1. Start LocalStack

Start LocalStack separately from Terraform:

```bash
docker run --rm -d \
  --name localstack \
  -p 4566:4566 \
  -e SERVICES=ec2 \
  localstack/localstack:2.3
