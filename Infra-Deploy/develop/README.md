# Infra-Deploy

This module is used to deploy and orchestrate the full AWS VPC API service infrastructure using all submodules.

## Features
- Orchestrates backend, core, networking, database, and serverless modules
- Centralized deployment and management
- Outputs all key resource identifiers and endpoints

## Usage
1. Configure variables in `variables.tf` or via CLI/TFVARS.
2. Run:
   ```sh
   terraform init
   terraform plan
   terraform apply
   ```
3. Retrieve outputs for API Gateway URL, Cognito pool/client/domain, Lambda ARNs, and more.

## Outputs
- VPC/subnet IDs
- Lambda ARNs
- API Gateway URL
- DynamoDB table name
- Cognito pool/client/domain
