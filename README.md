# terraform-aws-production-platform

Production-grade AWS infrastructure built with Terraform.

## Architecture

- **VPC**: 10.0.0.0/16 with DNS enabled
- **Public Subnets**: 2 AZs (us-east-1a, 1b) with Internet Gateway
- **Private Subnets**: 2 AZs (us-east-1a, 1b)
- **Security Groups**: ALB (80/443), App (8080), DB (5432)

## Stack

- Terraform + AWS Provider
- LocalStack for local validation

## Usage

```bash
docker run --rm -it -p 4566:4566 localstack/localstack:2.3
terraform init
terraform apply -auto-approve