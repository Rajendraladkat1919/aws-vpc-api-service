# aws-core-module

This module provisions core IAM resources required for the VPC API service:
- Lambda execution role and policy for secure access to DynamoDB and CloudWatch Logs
- IAM user for API management and automation

All IAM resources are managed centrally for security and reuse across modules. No cross-module dependencies are required.
