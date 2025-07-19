variable "terraform_state_bucket_name" {
  description = "The name of the S3 bucket to store Terraform state"
  type        = string
  default = "aws-service-api-terraform-state"
}

variable "dynamodb_state_lock_table_name" {
  description = "The name of the DynamoDB table to use for Terraform state locking"
  type        = string
  default = "terraform_lock_table_name"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

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
