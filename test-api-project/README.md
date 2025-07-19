# test-api-project

This folder contains example scripts and tools for testing the AWS VPC API service endpoints.

## Features
- Python script for authenticating with Cognito and calling API Gateway endpoints
- End-to-end test of Cognito authentication and API access

## Usage
1. Retrieve Cognito test user credentials and API Gateway URL from Terraform outputs.
2. Update `cognito_auth_test.py` with your Cognito region, client ID, username, and password.
3. Run the script:
   ```sh
   python3 cognito_auth_test.py
   ```
4. The script will authenticate with Cognito and test GET/PUT endpoints on the API Gateway.

## Example
See `cognito_auth_test.py` for a sample Python script to authenticate and call the API using Cognito credentials and JWT token.
