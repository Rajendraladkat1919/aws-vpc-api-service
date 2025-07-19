provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
resource "aws_s3_bucket" "terraform_remote_state" {
  bucket        = var.terraform_state_bucket_name
  force_destroy = false

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name        = "Terraform State Bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "terraform_remote_state_versioning" {
  bucket = aws_s3_bucket.terraform_remote_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_remote_state_sse" {
  bucket = aws_s3_bucket.terraform_remote_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "remote_tf_lock" {
  name = var.dynamodb_state_lock_table_name
  tags = {
    Name        = "Terraform Lock Table"
    Environment = var.environment
  }
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}