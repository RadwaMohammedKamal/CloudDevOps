# Security Group للـ ALB
resource "aws_security_group" "alb" {
  name        = "${var.environment}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

# Application Load Balancer
resource "aws_lb" "alb" {
  name               = "${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = [aws_security_group.alb.id]
  tags               = var.tags
}

# Target Group للـ ALB
resource "aws_lb_target_group" "tg" {
  name        = "${var.environment}-tg"
  port        = var.app_port
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}

# Listener للـ ALB
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.app_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# API Gateway
resource "aws_apigatewayv2_api" "this" {
  name          = "${var.environment}-http-api"
  protocol_type = "HTTP"
  tags          = var.tags
}

resource "aws_apigatewayv2_stage" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_authorizer" "jwt" {
  api_id           = aws_apigatewayv2_api.this.id
  name             = "cognito-jwt"
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]

  jwt_configuration {
    issuer   = "https://${var.cognito_user_pool_domain}"
    audience = [var.cognito_user_pool_client_id]
  }
}

resource "aws_apigatewayv2_integration" "this" {
  api_id                 = aws_apigatewayv2_api.this.id
  integration_type       = "HTTP_PROXY"
  integration_method     = "ANY"
  integration_uri        = "http://${aws_lb.alb.dns_name}:${var.app_port}"
  payload_format_version = "1.0"
}

resource "aws_apigatewayv2_route" "proxy" {
  api_id             = aws_apigatewayv2_api.this.id
  route_key          = "ANY /{proxy+}"
  target             = "integrations/${aws_apigatewayv2_integration.this.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.jwt.id
}


# # resource "aws_lb" "nlb" {
# #   name               = "${var.environment}-nlb"
# #   internal           = false
# #   load_balancer_type = "network"
# #   subnets            = var.public_subnets
# #   enable_deletion_protection = false
# #   tags               = var.tags
# # }
# resource "aws_lb" "alb" {
#   name               = "${var.environment}-alb"
#   internal           = false
#   load_balancer_type = "application"
#   subnets            = var.public_subnets
#   security_groups    = [aws_security_group.alb.id] 
#   tags               = var.tags
# }

# resource "aws_lb_target_group" "tg" {
#   name     = "${var.environment}-tg"
#   port     = var.app_port
#   protocol = "TCP"
#   vpc_id   = var.vpc_id
#   target_type = "ip"
# }

# resource "aws_lb_listener" "listener" {
#   # load_balancer_arn = aws_lb.nlb.arn
#   load_balancer_arn = aws_lb.alb.arn  
#   port              = var.app_port
#   protocol          = "TCP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.tg.arn
#   }
# }

# resource "aws_apigatewayv2_api" "this" {
#   name          = "${var.environment}-http-api"
#   protocol_type = "HTTP"
#   tags          = var.tags
# }

# resource "aws_apigatewayv2_stage" "this" {
#   api_id      = aws_apigatewayv2_api.this.id
#   name        = "$default"
#   auto_deploy = true
# }

# resource "aws_apigatewayv2_authorizer" "jwt" {
#   api_id           = aws_apigatewayv2_api.this.id
#   name             = "cognito-jwt"
#   authorizer_type  = "JWT"
#   identity_sources = ["$request.header.Authorization"]

#   jwt_configuration {
#     issuer   = "https://${var.cognito_user_pool_domain}"
#     audience = [var.cognito_user_pool_client_id]
#   }
# }

# resource "aws_apigatewayv2_integration" "this" {
#   api_id                 = aws_apigatewayv2_api.this.id
#   integration_type       = "HTTP_PROXY"
#   integration_method     = "ANY"
#   integration_uri = "http://${aws_lb.alb.dns_name}:${var.app_port}"
#   # integration_uri        = "http://${aws_lb.nlb.dns_name}:${var.app_port}"
#   payload_format_version = "1.0"
# }

# resource "aws_apigatewayv2_route" "proxy" {
#   api_id    = aws_apigatewayv2_api.this.id
#   route_key = "ANY /{proxy+}"
#   target    = "integrations/${aws_apigatewayv2_integration.this.id}"
#   authorization_type = "JWT"
#   authorizer_id      = aws_apigatewayv2_authorizer.jwt.id
# }
