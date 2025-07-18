variable "lambda_role_arn" {
  description = "IAM role ARN for Lambda"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
}

variable "lambda_arn" {
  description = "The ARN of the Lambda function"
}

variable "cognito_authorizer_arn" {
  description = "The ARN of the Cognito Authorizer"
}

variable "aws_region" {
  description = "AWS region"
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}
