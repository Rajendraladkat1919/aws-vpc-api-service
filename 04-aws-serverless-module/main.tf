provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_lambda_function" "vpc_metadata" {
  filename      = "lambda/vpc_metadata_lambda.zip"
  function_name = "VpcMetadataLambda"
  role          = var.lambda_role_arn
  handler       = "vpc_metadata_lambda.lambda_handler"
  runtime       = "python3.11" # Updated from python3.8
  memory_size   = 256
  timeout       = 30

  environment {
    variables = {
      DYNAMODB_TABLE_NAME = var.dynamodb_table_name
    }
  }

  tags = {
    Name        = "VpcMetadataLambda"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_api_gateway_rest_api" "vpc_api" {
  name        = "VPC API"
  description = "API to create and show VPC metadata"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = {
    Name        = "VPCAPI"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_api_gateway_resource" "vpc" {
  rest_api_id = aws_api_gateway_rest_api.vpc_api.id
  parent_id   = aws_api_gateway_rest_api.vpc_api.root_resource_id
  path_part   = "vpc"
}

resource "aws_api_gateway_method" "vpc_put" {
  rest_api_id   = aws_api_gateway_rest_api.vpc_api.id
  resource_id   = aws_api_gateway_resource.vpc.id
  http_method   = "PUT"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.main.id
}

resource "aws_api_gateway_method" "vpc_get" {
  rest_api_id   = aws_api_gateway_rest_api.vpc_api.id
  resource_id   = aws_api_gateway_resource.vpc.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.main.id
}

resource "aws_api_gateway_integration" "vpc_put_integration" {
  rest_api_id             = aws_api_gateway_rest_api.vpc_api.id
  resource_id             = aws_api_gateway_resource.vpc.id
  http_method             = aws_api_gateway_method.vpc_put.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.vpc_metadata.invoke_arn
}

resource "aws_api_gateway_integration" "vpc_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.vpc_api.id
  resource_id             = aws_api_gateway_resource.vpc.id
  http_method             = aws_api_gateway_method.vpc_get.http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.vpc_metadata.invoke_arn
}

resource "aws_lambda_permission" "allow_apigw_vpc_metadata" {
  statement_id  = "AllowExecutionFromAPIGatewayVpcMetadata"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.vpc_metadata.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.vpc_api.execution_arn}/*/*"
}

resource "aws_cognito_user_pool" "main" {
  name = "vpc-api-user-pool"

  tags = {
    Name        = "VPCAPIUserPool"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_cognito_user_pool_client" "main" {
  name            = "vpc-api-client"
  user_pool_id    = aws_cognito_user_pool.main.id
  generate_secret = false
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "vpc-api-domain-${var.environment}"
  user_pool_id = aws_cognito_user_pool.main.id
}

resource "random_password" "cognito_user_password" {
  length  = 16
  special = true
}

resource "aws_cognito_user" "test_user" {
  user_pool_id       = aws_cognito_user_pool.main.id
  username           = var.cognito_user_name
  temporary_password = random_password.cognito_user_password.result
  attributes = {
    email = "raladevops1@gmail.com"
  }
  force_alias_creation = false
}

resource "aws_api_gateway_authorizer" "main" {
  name            = "vpc-api-cognito-authorizer"
  rest_api_id     = aws_api_gateway_rest_api.vpc_api.id
  type            = "COGNITO_USER_POOLS"
  provider_arns   = [aws_cognito_user_pool.main.arn]
  identity_source = "method.request.header.Authorization"
}

resource "aws_api_gateway_deployment" "vpc_api_deployment" {
  depends_on = [
    aws_api_gateway_integration.vpc_put_integration,
    aws_api_gateway_integration.vpc_get_integration
  ]
  rest_api_id = aws_api_gateway_rest_api.vpc_api.id
}
