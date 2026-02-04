# output "nlb_dns" { value = aws_lb.nlb.dns_name }
output "alb_dns" {
  value = aws_lb.alb.dns_name
}

output "api_gateway_url" {
  value = aws_apigatewayv2_stage.this.invoke_url
}

output "alb_sg_id" {
  value = aws_security_group.alb.id
}
