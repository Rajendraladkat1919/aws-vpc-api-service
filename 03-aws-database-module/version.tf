terraform {
  required_version = ">= 1.5.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "aws-service-api-terraform-state"
    key    = "database/terraform.tfstate"
    region = "eu-central-1"
  }
}