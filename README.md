<div align="center">

<h1 align="center"><strong>🏗️ Terraform AWS Platform Lab</strong></h1>

**A hands-on Infrastructure-as-Code project focused on designing and validating a secure AWS network foundation.**

<p>
  <img src="https://img.shields.io/badge/Terraform-7B42BC?logo=terraform&logoColor=white" alt="Terraform" />
  <img src="https://img.shields.io/badge/AWS-FF9900?logo=amazonaws&logoColor=white" alt="AWS" />
  <img src="https://img.shields.io/badge/LocalStack-4B5563?logo=localstack&logoColor=white" alt="LocalStack" />
  <img src="https://img.shields.io/badge/Status-Early_Development-orange" alt="Status" />
</p>

*An independent infrastructure engineering project by [Ziad](https://github.com/2nothing4).*

</div>

---

> [!IMPORTANT]
> **Project Status:** Early Development  
> **Validation Environment:** LocalStack  
> **Real AWS Deployment:** Not deployed
> This repository represents infrastructure-as-code development and local validation, not a production AWS deployment.

## 📑 Table of Contents
- [Objectives](#objectives)
- [Current Implementation](#current-implementation)
- [Target Architecture](#target-architecture)
- [Technology Stack](#technology-stack)
- [Local Development](#local-development)
- [State & Dependency Management](#state--dependency-management)
- [Validation Boundaries](#validation-boundaries)
- [Planned Milestones](#planned-milestones)

---

## 🎯 Objectives

- Build a configurable AWS VPC foundation.
- Separate public and private network tiers.
- Define explicit routing and security boundaries.
- Use reusable, maintainable Terraform configuration.
- Validate infrastructure changes before deployment.
- Automate formatting, validation, and security checks through CI.

## 🏗️ Current Implementation

The initial Terraform configuration declares the following building blocks:

| Component | Current Configuration |
| :--- | :--- |
| **VPC** | `10.0.0.0/16` with DNS support and hostnames enabled |
| **Public Subnets** | Two subnets across two Availability Zones |
| **Private Subnets** | Two subnets across two Availability Zones |
| **Internet Gateway** | Attached to the VPC |
| **Public Route Table** | Default route through Internet Gateway |
| **Private Route Table** | Separate route table without a default internet route |
| **Security Groups** | ALB (TCP 80/443), App (TCP 8080), DB (TCP 5432) |

> [!NOTE]
> These are infrastructure resource definitions. The current implementation does not yet create an actual Application Load Balancer, application compute resources, an RDS database, or an EKS cluster.

## 🚀 Target Architecture

The intended architecture will evolve toward:
- A VPC distributed across two Availability Zones.
- Public subnets for internet-facing ingress.
- Private application subnets.
- Isolated private data subnets.
- Explicit security-group relationships.
- Deliberate private-subnet egress design.

## 🛠️ Technology Stack

- **Terraform** & HashiCorp AWS Provider
- **LocalStack** for local AWS API simulation
- **GitHub Actions** for infrastructure validation
- **Checkov** & **TFLint** for configuration quality and security review

## 💻 Local Development

Start the configured LocalStack environment separately, then run Terraform from the repository root.

### 1. Initialize the working directory
```bash
terraform init
