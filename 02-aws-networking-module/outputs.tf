output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "The Public Subnet IDs"
  value       = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

output "private_subnet_ids" {
  description = "The Private Subnet IDs"
  value       = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}

output "internet_gateway_id" {
  description = "The Internet Gateway ID"
  value       = aws_internet_gateway.main.id
}

output "dynamodb_vpc_endpoint_id" {
  description = "The VPC Endpoint ID for DynamoDB"
  value       = aws_vpc_endpoint.dynamodb.id
}

output "lambda_vpc_endpoint_id" {
  description = "The VPC Endpoint ID for Lambda"
  value       = aws_vpc_endpoint.lambda.id
}

output "apigateway_vpc_endpoint_id" {
  description = "The VPC Endpoint ID for API Gateway"
  value       = aws_vpc_endpoint.apigateway.id
}
