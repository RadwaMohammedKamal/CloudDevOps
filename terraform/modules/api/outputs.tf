output "nlb_dns" {
  value       = aws_lb.app_nlb.dns_name
  description = "NLB DNS name"
}

output "nlb_sg_id" {
  value       = aws_security_group.nlb_sg.id
  description = "Security group ID of the NLB"
}

output "vpc_link_sg_id" {
  value       = aws_security_group.vpc_link_sg.id
  description = "VPC Link Security Group ID"
}

output "cognito_user_pool_id" {
  value       = aws_cognito_user_pool.user_pool.id
  description = "Cognito User Pool ID"
}

output "cognito_user_pool_client_id" {
  value       = aws_cognito_user_pool_client.user_pool_client.id
  description = "Cognito User Pool Client ID"
}

output "api_gateway_url" {
  value       = aws_apigatewayv2_stage.default_stage.invoke_url
  description = "API Gateway base URL"
}