# aws-networking-module

This module provisions the networking infrastructure for the AWS VPC API service.

## Features
- VPC with public and private subnets
- Internet Gateway, NAT Gateway, and VPC endpoints
- Subnet and VPC tagging for easy identification
- Outputs for VPC ID, subnet IDs, and endpoint IDs

## Usage
1. Configure variables in `variables.tf` or via CLI/TFVARS.
2. Run:
   ```sh
   terraform init
   terraform plan
   terraform apply
   ```
3. Networking resources will be created for use by other modules.

## Security
- Subnets and endpoints are provisioned with security groups
- Follows AWS best practices for networking

## Outputs
- VPC ID
- Subnet IDs
- VPC endpoint IDs
