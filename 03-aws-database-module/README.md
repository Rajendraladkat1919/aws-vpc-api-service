# aws-database-module

This module provisions a DynamoDB table for storing metadata about VPCs and subnets created by the API service.
- Table is fully managed and uses on-demand billing
- Schema is optimized for storing VPC and subnet details

## Features
- DynamoDB table for VPC/subnet metadata
- On-demand billing mode
- Outputs for table name and ARN

## Usage
1. Configure variables in `variables.tf` or via CLI/TFVARS.
2. Run:
   ```sh
   terraform init
   terraform plan
   terraform apply
   ```
3. DynamoDB table will be created for use by Lambda and other modules.

## Security
- Table access is controlled by IAM policies
- Data is encrypted at rest

## Outputs
- DynamoDB table name
- DynamoDB table ARN
