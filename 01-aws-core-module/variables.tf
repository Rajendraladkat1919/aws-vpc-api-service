variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "eu-central-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use for authentication"
  type        = string
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
variable "owner" {
  description = "Owner of the resources"
  type        = string
  default = "rajendra.ladkat"
  
}