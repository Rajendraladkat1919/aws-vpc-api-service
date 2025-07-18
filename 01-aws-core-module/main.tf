resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
  tags = {
    Name        = "LambdaExecutionRole"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_iam_policy" "lambda_exec_policy" {
  name        = "lambda_exec_policy"
  description = "Allow Lambda to access DynamoDB and CloudWatch Logs"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:Scan",
          "dynamodb:UpdateItem"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_exec_policy.arn
}

resource "aws_iam_user" "api_user" {
  name = "vpc-api-user"
  tags = {
    Name        = "VPCAPIUser"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_iam_user_policy_attachment" "api_user_policy" {
  user       = aws_iam_user.api_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" // Restrict as needed
}
