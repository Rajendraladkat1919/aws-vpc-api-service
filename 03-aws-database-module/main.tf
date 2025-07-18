resource "aws_dynamodb_table" "vpc_metadata" {
  name         = var.table_name
  hash_key     = "id"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    "Name" = "VPCMetadataTable"
  }
}

