# aws-networking-module

This module provisions all networking resources for the VPC API service:
- VPC with configurable CIDR block
- Public and private subnets across multiple availability zones
- Internet Gateway for public connectivity
- Private VPC endpoints for Lambda, DynamoDB, and API Gateway
- Enhanced tagging for environment, project, and owner

Outputs include VPC ID, subnet IDs, internet gateway ID, and VPC endpoint IDs for integration with other modules.
