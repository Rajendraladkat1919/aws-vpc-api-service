provider "aws" {
  region = var.aws_region
}

module "core" {
  source       = "../01-aws-core-module"
  aws_region   = var.aws_region
  aws_profile  = var.aws_profile
  project_name = var.project_name
  environment  = var.environment
  owner        = var.owner
}

module "networking" {
  source               = "../02-aws-networking-module"
  aws_region           = var.aws_region
  aws_profile          = var.aws_profile
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  environment          = var.environment
  project_name         = var.project_name
  owner                = var.owner
}

module "database" {
  source               = "../03-aws-database-module"
  table_name           = var.dynamodb_table_name
  aws_region           = var.aws_region
  aws_profile          = var.aws_profile
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  environment          = var.environment
  project_name         = var.project_name
}

module "serverless" {
  source              = "../04-aws-serverless-module"
  lambda_role_arn     = var.lambda_role_arn
  dynamodb_table_name = var.dynamodb_table_name
  aws_region          = var.aws_region
  aws_profile         = var.aws_profile
  project_name        = var.project_name
  environment         = var.environment
}


