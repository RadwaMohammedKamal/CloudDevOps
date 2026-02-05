output "alb_dns" {
  value = aws_lb.app_alb.dns_name
}

output "api_gateway_url" {
  value = aws_apigatewayv2_stage.default_stage.invoke_url
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.user_pool.id
}

output "cognito_user_pool_client_id" {
  value = aws_cognito_user_pool_client.user_pool_client.id
}
