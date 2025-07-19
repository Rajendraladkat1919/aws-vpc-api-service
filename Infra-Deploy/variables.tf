variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "eu-central-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use for authentication"
  type        = string
  default     = "default"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Map of public subnet CIDRs by availability zone"
  type        = map(string)
  default = {
    "eu-central-1a" = "10.0.1.0/24"
    "eu-central-1b" = "10.0.2.0/24"
  }
}

variable "private_subnet_cidrs" {
  description = "Map of private subnet CIDRs by availability zone"
  type        = map(string)
  default = {
    "eu-central-1a" = "10.0.3.0/24"
    "eu-central-1b" = "10.0.4.0/24"
  }
}

variable "availability_zones" {
  description = "List of availability zones used"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for storing VPC and subnet data"
  type        = string
  default     = "vpc_metadata"
}

variable "cognito_authorizer_arn" {
  description = "ARN of the Cognito authorizer for API Gateway"
  type        = string
}

variable "lambda_arn" {
  description = "ARN of the Lambda function to be invoked"
  type        = string
}

variable "lambda_role_arn" {
  description = "IAM role ARN for Lambda"
  type        = string
}