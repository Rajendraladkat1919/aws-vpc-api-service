variable "lambda_role_arn" {
  description = "IAM role ARN for Lambda"
  type        = string
  default = "arn:aws:iam::160071257600:role/lambda_exec_role"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default = "VPCMetadata"
}

variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "eu-central-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use for authentication"
  type        = string
  default     = "160071257600_PowerUserPlusRole"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default = "demo-project"
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}
