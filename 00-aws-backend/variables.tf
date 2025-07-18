variable "tf_state_bucket_name" {
  description = "The name of the S3 bucket to store Terraform state"
  type        = string
}

variable "tf_lock_table_name" {
  description = "The name of the DynamoDB table to use for Terraform state locking"
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}
