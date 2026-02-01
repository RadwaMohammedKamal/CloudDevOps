variable "environment" { type = string }
variable "vpc_id" { type = string }
variable "public_subnets" { type = list(string) }
variable "cognito_user_pool_domain" { type = string }
variable "cognito_user_pool_client_id" { type = string }
variable "app_port" { type = number }
variable "tags" { type = map(string) }
