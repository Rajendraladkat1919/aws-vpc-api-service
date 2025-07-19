output "vpc_id" {
  value = module.networking.vpc_id
}
output "dynamodb_table_name" {
  value = module.database.dynamodb_table_name
}
output "api_gateway_url" {
  value = module.serverless.api_gateway_url
}
output "cognito_user_pool_id" {
  value = module.serverless.cognito_user_pool_id
}