output "lambda_exec_role_arn" {
  description = "ARN of the Lambda execution role"
  value       = aws_iam_role.lambda_exec_role.arn
}

output "lambda_exec_policy_arn" {
  description = "ARN of the Lambda execution policy"
  value       = aws_iam_policy.lambda_exec_policy.arn
}