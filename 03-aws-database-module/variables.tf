variable "table_name" {
  description = "The name of the DynamoDB table"
  default     = "VPCMetadata"
}

variable "aws_region" {
  description = "AWS region to deploy resources in"
  default     = "eu-central-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use for authentication"
  default     = "160071257600_PowerUserPlusRole"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
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

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  default     = "dev"
}

variable "project_name" {
  description = "Name of the project"
  default     = "aws-vpc-api-service"
}

variable "owner" {
  description = "Owner of the resources"
  default     = "rajendraladkat"
}