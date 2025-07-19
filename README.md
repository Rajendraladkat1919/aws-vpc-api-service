# AWS VPC API Service

This repository provides a production-ready, modular, and secure API service for automated AWS VPC and subnet management, using Terraform and Python. It enables authenticated users to create and retrieve VPC/subnet metadata via a Cognito-protected API Gateway, with all infrastructure managed as code.

---

## Problem Statement
Manual VPC/subnet creation is error-prone and lacks governance. This solution automates VPC provisioning and metadata management via a secure API, with authentication and auditability.

## Solution Overview
- **API Gateway**: Exposes endpoints for VPC/subnet creation and metadata retrieval, protected by Cognito authentication.
- **Lambda (Python, boto3)**: Handles VPC/subnet operations and DynamoDB metadata storage.
- **Terraform Modules**: Orchestrate all AWS resources with best practices for security, modularity, and maintainability.

## Repository Structure
- `00-aws-backend`: S3/DynamoDB backend for remote state and locking
- `01-aws-core-module`: Centralized IAM roles/policies
- `02-aws-networking-module`: VPC, subnets, endpoints
- `03-aws-database-module`: DynamoDB table for metadata
- `04-aws-serverless-module`: Lambda, API Gateway, Cognito, test user
- `Infra-Deploy`: Root orchestrator for all modules (supports multiple environments)
- `test-api-project`: Python script for Cognito authentication and API testing

## Prerequisites
- Terraform >= 1.5.7
- AWS CLI
- AWS account and credentials
- Python 3 (for API testing)

## How to Use This Repository

### Infrastructure Provisioning
You can provision infrastructure by:
1. Running `terraform apply` in each module folder sequentially (see below).
2. Using the `Infra-Deploy` folder for environment-based orchestration (develop, staging, production) or Terraform workspaces.

### Step-by-Step Deployment

1. **Create the remote backend bucket and lock the state in DynamoDB**
   ```sh
   cd 00-aws-backend
   terraform init
   terraform plan
   terraform apply
   ```
2. **Provision core IAM roles and policies**
   ```sh
   cd 01-aws-core-module
   terraform init
   terraform plan
   terraform apply
   ```
3. **Provision networking resources (VPC, subnets, endpoints)**
   ```sh
   cd 02-aws-networking-module
   terraform init
   terraform plan
   terraform apply
   ```
4. **Provision the DynamoDB table for VPC/subnet metadata**
   ```sh
   cd 03-aws-database-module
   terraform init
   terraform plan
   terraform apply
   ```
5. **Provision serverless resources (Lambda, API Gateway, Cognito, test user)**
   ```sh
   cd 04-aws-serverless-module
   terraform init
   terraform plan
   terraform apply
   ```

Once deployed, the API Gateway endpoint will be available for VPC/subnet creation and retrieval. You can test the API using Postman, curl, or the provided Python script.

---

## Example API Test
See `test-api-project/cognito_auth_test.py` for a sample Python script to authenticate and call the API using Cognito credentials and JWT token.

### Step-by-Step API Testing
1. **Retrieve Cognito test user credentials and API Gateway URL**
   ```sh
   terraform output -module=serverless cognito_test_user_password
   terraform output -module=serverless cognito_user_pool_client_id
   terraform output -module=serverless api_gateway_invoke_url
   ```
2. **Update the Python test script**
   - Open `test-api-project/cognito_auth_test.py`.
   - Set `COGNITO_REGION`, `USER_POOL_CLIENT_ID`, `API_URL`, `USERNAME`, and `PASSWORD` to the values from Terraform outputs.
3. **Install dependencies**
   ```sh
   pip install boto3 requests
   ```
4. **Run the test script**
   ```sh
   python3 test-api-project/cognito_auth_test.py
   ```
   - The script will authenticate with Cognito, call the API Gateway endpoint, and print the status and response for GET and PUT requests.
5. **Alternative: Test with Postman or curl**
   ```sh
   curl -X PUT \
     '<api_gateway_invoke_url>/put' \
     -H "Authorization: <your-jwt-token>" \
     -H "Content-Type: application/json" \
     -d '{"vpc_id": "vpc-123", "subnet_id": "subnet-456"}'
   ```

---

## Security & Best Practices
- All modules follow AWS best practices for IAM, encryption, and resource tagging.
- API is protected by Cognito authorizer; only authenticated users can access endpoints.
- S3/DynamoDB state is encrypted and access-restricted.
- Sensitive variables are handled securely; no secrets are committed.
- Disaster recovery: S3 bucket versioning and lifecycle policies for state backup.

## CI/CD & Validation
- Use GitHub Actions or similar for Terraform format/lint checks, automated plan/apply, and state file protection.
- Run `terraform validate` and `terraform plan` in CI.

## Snippets & Screenshots

1. **Backend provisioning**
   ![Backend provisioning](Screenshot%202025-07-19%20at%206.25.28%E2%80%AFPM.png)
2. **Testing VPC creation logic using Lambda**
   
3. **Testing VPC get data using DynamoDB**

4. **DynamoDB stores resource details**
   ![DynamoDB store](Screenshot%202025-07-19%20at%206.26.11%E2%80%AFPM-1.png)

---

## Summary
This repository delivers a secure, modular, and production-ready AWS VPC API service with full infrastructure-as-code, authentication, and automated testing. Follow the documentation and TDD approach for reliable deployment and operations.