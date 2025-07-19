# Local for common tags
locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    Owner       = var.owner
  }
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = "MainVPC"
  })
}

# Public Subnets
resource "aws_subnet" "public" {
  for_each = var.public_subnet_cidrs

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "PublicSubnet-${each.key}"
  })
}

# Private Subnets
resource "aws_subnet" "private" {
  for_each = var.private_subnet_cidrs

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = false

  tags = merge(local.common_tags, {
    Name = "PrivateSubnet-${each.key}"
  })
}

# Route Tables for private subnets
resource "aws_route_table" "private" {
  for_each = var.private_subnet_cidrs

  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "PrivateRouteTable-${each.key}"
  })
}

# Route table associations for private subnets
resource "aws_route_table_association" "private" {
  for_each = var.private_subnet_cidrs

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "MainIGW"
  })
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
