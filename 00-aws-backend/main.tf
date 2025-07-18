resource "aws_s3_bucket" "terraform_remote_state" {
  bucket        = var.tf_state_bucket_name
  force_destroy = true

  lifecycle {
    prevent_destroy = false
  }

  versioning {
    enabled = true
  }

  tags = {
    Name        = "Terraform State Bucket"
    Environment = var.environment
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
  name         = var.tf_lock_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = var.environment
  }
}