output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.main.id
}

output "subnet_ids" {
  description = "The Subnet IDs"
  value       = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
}
