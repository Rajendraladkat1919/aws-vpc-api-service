output "vpc_metadata_lambda_arn" {
  description = "The ARN of the VpcMetadata Lambda function"
  value       = aws_lambda_function.vpc_metadata.arn
}

output "api_gateway_id" {
  description = "The ID of the API Gateway"
  value       = aws_api_gateway_rest_api.vpc_api.id
}

output "api_gateway_url" {
  description = "The execution URL of the API Gateway"
  value       = aws_api_gateway_rest_api.vpc_api.execution_arn
}

output "api_gateway_invoke_url" {
  description = "Invoke URL for the API Gateway"
  value       = "https://${aws_api_gateway_rest_api.vpc_api.id}.execute-api.${var.aws_region}.amazonaws.com/${var.environment}"
}

output "cognito_user_pool_id" {
  description = "Cognito User Pool ID for authentication"
  value       = aws_cognito_user_pool.main.id
}

output "cognito_user_pool_client_id" {
  description = "Cognito User Pool Client ID for authentication"
  value       = aws_cognito_user_pool_client.main.id
}

output "cognito_user_pool_domain" {
  description = "Cognito User Pool Domain for authentication"
  value       = aws_cognito_user_pool_domain.main.domain
}

output "cognito_test_user_password" {
  description = "Generated password for Cognito test user (sensitive)"
  value       = random_password.cognito_user_password.result
  sensitive   = true
}