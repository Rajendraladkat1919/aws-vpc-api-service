# aws-serverless-module

This module provisions the serverless components for the AWS VPC API service, including:
- AWS Lambda function for VPC and subnet creation/retrieval (Python, boto3)
- API Gateway with Cognito authorizer for secure, authenticated API access
- Cognito User Pool and User Pool Client for authentication
- Test user creation with a securely generated password

## Features
- Secure API endpoints for VPC/subnet management
- Lambda function with least-privilege IAM role
- API Gateway protected by Cognito authorizer (token source: Authorization header)
- Outputs for API Gateway URL, Cognito pool/client/domain, Lambda ARN, and test user credentials

## Usage
1. Configure variables in `variable.tf` or via CLI/TFVARS.
2. Run:
   ```sh
   terraform init
   terraform plan
   terraform apply
   ```
3. Retrieve outputs for API Gateway URL, Cognito pool/client/domain, and test user password.
4. Use the provided Python script to authenticate and test the API.

## Security
- API access requires a valid Cognito JWT token in the `Authorization` header
- Test user password is generated securely and output as a sensitive value
- IAM roles and policies follow least-privilege principles

## Outputs
- Lambda function ARN
- API Gateway URL and invoke URL
- Cognito User Pool ID, Client ID, and Domain
- Test user password (sensitive)

## Example API Test
See `test-api-project/cognito_auth_test.py` for a sample Python script to authenticate and call the API using Cognito credentials and JWT token.
