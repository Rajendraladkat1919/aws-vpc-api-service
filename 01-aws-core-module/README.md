# aws-core-module

This module provisions core IAM roles and policies for the AWS VPC API service.

## Features
- Centralized IAM roles and policies for Lambda, API Gateway, and other resources
- Least-privilege access control
- Outputs for IAM role ARNs and policy ARNs

## Usage
1. Configure variables in `variables.tf` or via CLI/TFVARS.
2. Run:
   ```sh
   terraform init
   terraform plan
   terraform apply
   ```
3. IAM roles and policies will be created for use by other modules.

## Security
- Follows AWS best practices for IAM
- Roles and policies are tightly scoped

## Outputs
- IAM role ARNs
- IAM policy ARNs
