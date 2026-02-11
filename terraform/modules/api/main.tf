# ----------------------------
# Security Group for VPC Link
# ----------------------------
resource "aws_security_group" "vpc_link_sg" {
  name   = "${var.environment}-vpc-link-sg"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

# ----------------------------
# VPC Link
# ----------------------------
resource "aws_apigatewayv2_vpc_link" "vpc_link" {
  name               = "${var.environment}-vpc-link"
  subnet_ids         = var.private_subnets
  security_group_ids = [aws_security_group.vpc_link_sg.id]
}

# ----------------------------
# API Gateway
# ----------------------------
resource "aws_apigatewayv2_api" "http_api" {
  name          = "${var.environment}-http-api"
  protocol_type = "HTTP"
  tags          = var.tags
}

# ----------------------------
# NLB Integration (APP) using NLB DNS
# ----------------------------
resource "aws_apigatewayv2_integration" "nlb_integration" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "HTTP_PROXY"
  integration_method     = "ANY"
  integration_uri        = var.nlb_listener_arn 
  connection_type        = "VPC_LINK"
  connection_id          = aws_apigatewayv2_vpc_link.vpc_link.id
  payload_format_version = "1.0"
}
# ----------------------------
# Route (Catch-all)
# ----------------------------
resource "aws_apigatewayv2_route" "api_route" {
  api_id    = aws_apigatewayv2_api.http_api.id

  #  paths
  route_key = "ANY /{proxy+}"

  target = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
}
# ----------------------------
# Stage
# ----------------------------
resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
}
# # ----------------------------
# # Route /app
# # ----------------------------
# resource "aws_apigatewayv2_route" "app_route" {
#   api_id    = aws_apigatewayv2_api.http_api.id
#   route_key = "ANY /app/{proxy+}"
#   target    = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
# }







# ##########################
# # NLB
# ##########################
# resource "aws_lb" "app_nlb" {
#   name               = "${var.environment}-nlb"
#   load_balancer_type = "network"
#   internal           = false
#   subnets            = var.public_subnets
#   security_groups    = [aws_security_group.nlb_sg.id]
#   tags               = var.tags
# }

# ##########################
# # Security Group for NLB
# ##########################
# resource "aws_security_group" "nlb_sg" {
#   name   = "${var.environment}-nlb_sg"
#   vpc_id = var.vpc_id

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = var.tags
# }

# ##########################
# # Target Group (TCP)
# ##########################
# resource "aws_lb_target_group" "app_tg" {
#   name        = "${var.environment}-tg"
#   port        = 80
#   protocol    = "TCP"
#   vpc_id      = var.vpc_id
#   target_type = "ip"

#   health_check {
#     protocol            = "TCP"
#     port                = "traffic-port"
#     healthy_threshold   = 3
#     unhealthy_threshold = 3
#     timeout             = 5
#     interval            = 10
#   }
# }

# ##########################
# # Listener (TCP)
# ##########################
# resource "aws_lb_listener" "nlb_listener" {
#   load_balancer_arn = aws_lb.app_nlb.arn
#   port              = 80
#   protocol          = "TCP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.app_tg.arn
#   }
# }

# ##########################
# # Security Group for VPC Link
# ##########################
# resource "aws_security_group" "vpc_link_sg" {
#   name   = "${var.environment}-vpc-link-sg"
#   vpc_id = var.vpc_id

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = var.tags
# }

# ##########################
# # VPC Link
# ##########################
# resource "aws_apigatewayv2_vpc_link" "vpc_link" {
#   name               = "${var.environment}-vpc-link"
#   subnet_ids         = var.public_subnets
#   security_group_ids = [aws_security_group.vpc_link_sg.id]
# }

# ##########################
# # API Gateway
# ##########################
# resource "aws_apigatewayv2_api" "http_api" {
#   name          = "${var.environment}-http-api"
#   protocol_type = "HTTP"
#   tags          = var.tags
# }

# ##########################
# # Integration
# ##########################
# resource "aws_apigatewayv2_integration" "nlb_integration" {
#   api_id                 = aws_apigatewayv2_api.http_api.id
#   integration_type       = "HTTP_PROXY"
#   integration_method     = "ANY"
#   integration_uri        = aws_lb_listener.nlb_listener.arn
#   connection_type        = "VPC_LINK"
#   connection_id          = aws_apigatewayv2_vpc_link.vpc_link.id
#   payload_format_version = "1.0"
# }

# ##########################
# # Stage
# ##########################
# resource "aws_apigatewayv2_stage" "default_stage" {
#   api_id      = aws_apigatewayv2_api.http_api.id
#   name        = "$default"
#   auto_deploy = true
# }

# ##########################
# # Routes
# ##########################
# resource "aws_apigatewayv2_route" "proxy_route" {
#   api_id    = aws_apigatewayv2_api.http_api.id
#   route_key = "ANY /{proxy+}"
#   target    = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
# }

# resource "aws_apigatewayv2_route" "app_route" {
#   api_id    = aws_apigatewayv2_api.http_api.id
#   route_key = "ANY /app/{proxy+}"
#   target    = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
# }

# resource "aws_apigatewayv2_route" "argo_route" {
#   api_id    = aws_apigatewayv2_api.http_api.id
#   route_key = "ANY /argo/{proxy+}"
#   target    = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
# }




# ##########################
# # NLB with cognito
# ##########################
# resource "aws_lb" "app_nlb" {
#   name               = "${var.environment}-nlb"
#   load_balancer_type = "network"
#   internal           = true
#   subnets            = var.public_subnets
#   security_groups    = [aws_security_group.nlb_sg.id]   
#   tags               = var.tags
# }

# ##########################
# # Security Group for NLB
# ##########################
# resource "aws_security_group" "nlb_sg" {
#   name   = "${var.environment}-nlb_sg"
#   vpc_id = var.vpc_id

#   ingress {
#     from_port   = 0
#     to_port     = 65535
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]   
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = var.tags
# }

# ##########################
# # Target Group (TCP) - NLB
# ##########################
# resource "aws_lb_target_group" "app_tg" {
#   name        = "${var.environment}-tg"
#   port        = var.app_port
#   protocol    = "TCP"
#   vpc_id      = var.vpc_id
#   target_type = "ip"

#   lifecycle {
#     prevent_destroy = false
#   }
# }

# ##########################
# # Listener
# ##########################
# resource "aws_lb_listener" "nlb_listener" {
#   load_balancer_arn = aws_lb.app_nlb.arn
#   port              = var.app_port
#   protocol          = "TCP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.app_tg.arn
#   }

#   depends_on = [aws_lb_target_group.app_tg] # Listener يعتمد على Target Group
# }

# ##########################
# # Security Group for VPC Link
# ##########################
# resource "aws_security_group" "vpc_link_sg" {
#   name   = "${var.environment}-vpc-link-sg"
#   vpc_id = var.vpc_id

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = var.tags
# }

# ##########################
# # VPC Link 
# ##########################
# resource "aws_apigatewayv2_vpc_link" "vpc_link" {
#   name               = "${var.environment}-vpc-link"
#   subnet_ids         = var.public_subnets
#   security_group_ids = [aws_security_group.vpc_link_sg.id]
# }

# ##########################
# # API Gateway
# ##########################
# resource "aws_apigatewayv2_api" "http_api" {
#   name          = "${var.environment}-http-api"
#   protocol_type = "HTTP"
#   tags          = var.tags
# }

# ##########################
# # Cognito User Pool
# ##########################
# resource "aws_cognito_user_pool" "user_pool" {
#   name = "${var.environment}-user-pool"

#   auto_verified_attributes = ["email"]

#   password_policy {
#     minimum_length    = 8
#     require_uppercase = true
#     require_lowercase = true
#     require_numbers   = true
#     require_symbols   = false
#   }
# }

# ##########################
# # Cognito Client
# ##########################
# resource "aws_cognito_user_pool_client" "user_pool_client" {
#   name         = "${var.environment}-user-pool-client"
#   user_pool_id = aws_cognito_user_pool.user_pool.id

#   generate_secret = false

#   explicit_auth_flows = [
#     "ALLOW_USER_PASSWORD_AUTH",
#     "ALLOW_REFRESH_TOKEN_AUTH",
#     "ALLOW_USER_SRP_AUTH"
#   ]

#   supported_identity_providers = ["COGNITO"]
# }

# ##########################
# # JWT Authorizer
# ##########################
# resource "aws_apigatewayv2_authorizer" "cognito_jwt_authorizer" {
#   api_id           = aws_apigatewayv2_api.http_api.id
#   name             = "cognito-jwt"
#   authorizer_type  = "JWT"
#   identity_sources = ["$request.header.Authorization"]

#   jwt_configuration {
#     issuer   = "https://cognito-idp.${var.region}.amazonaws.com/${aws_cognito_user_pool.user_pool.id}"
#     audience = [aws_cognito_user_pool_client.user_pool_client.id]
#   }
# }

# ##########################
# # Integration: API Gateway → VPC Link → NLB
# ##########################
# resource "aws_apigatewayv2_integration" "nlb_integration" {
#   api_id           = aws_apigatewayv2_api.http_api.id
#   integration_type = "HTTP_PROXY"
#   integration_method = "ANY"
#   integration_uri    = aws_lb_listener.nlb_listener.arn
#   connection_type = "VPC_LINK"
#   connection_id   = aws_apigatewayv2_vpc_link.vpc_link.id
#   payload_format_version = "1.0"

#   depends_on = [aws_lb_listener.nlb_listener]
# }

# ##########################
# # Stage
# ##########################
# resource "aws_apigatewayv2_stage" "default_stage" {
#   api_id      = aws_apigatewayv2_api.http_api.id
#   name        = "$default"
#   auto_deploy = true
# }

# ##########################
# # Routes (JWT protected)
# ##########################

# # Proxy route
# resource "aws_apigatewayv2_route" "jwt_proxy_route" {
#   api_id             = aws_apigatewayv2_api.http_api.id
#   route_key          = "ANY /{proxy+}"
#   target             = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
#   authorization_type = "JWT"
#   authorizer_id      = aws_apigatewayv2_authorizer.cognito_jwt_authorizer.id
# }

# # App route
# resource "aws_apigatewayv2_route" "app_route" {
#   api_id             = aws_apigatewayv2_api.http_api.id
#   route_key          = "ANY /app/{proxy+}"
#   target             = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
#   authorization_type = "JWT"
#   authorizer_id      = aws_apigatewayv2_authorizer.cognito_jwt_authorizer.id
# }

# # Argo CD route
# resource "aws_apigatewayv2_route" "argo_route" {
#   api_id             = aws_apigatewayv2_api.http_api.id
#   route_key          = "ANY /argo/{proxy+}"
#   target             = "integrations/${aws_apigatewayv2_integration.nlb_integration.id}"
#   authorization_type = "JWT"
#   authorizer_id      = aws_apigatewayv2_authorizer.cognito_jwt_authorizer.id
# }


