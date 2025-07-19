# aws-backend-module

This module provisions the backend configuration for Terraform state management using AWS S3 and DynamoDB for state locking and consistency.

## Features
- S3 bucket for remote Terraform state
- DynamoDB table for state locking
- Secure and highly available backend setup

## Usage
1. Configure variables in `variables.tf` or via CLI/TFVARS.
2. Run:
   ```sh
   terraform init
   terraform plan
   terraform apply
   ```
3. Backend resources will be created for use by other modules.

## Security
- State file is stored securely in S3
- DynamoDB table prevents concurrent state changes

## Outputs
- S3 bucket name
- DynamoDB table name
