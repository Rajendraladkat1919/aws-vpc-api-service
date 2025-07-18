# aws-database-module

This module provisions a DynamoDB table for storing metadata about VPCs and subnets created by the API service.
- Table is fully managed and uses on-demand billing
- Schema is optimized for storing VPC and subnet details

Outputs include the table name for use by Lambda functions and other modules.
