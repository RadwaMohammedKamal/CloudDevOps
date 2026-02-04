variable "region" { type = string }
variable "environment" { type = string }
variable "vpc_cidr" { type = string }
variable "azs" { type = list(string) }
variable "public_subnet_cidrs" { type = list(string) }
variable "private_subnet_cidrs" { type = list(string) }
variable "data_subnet_cidrs" { type = list(string) }
variable "tags" { type = map(string)}
variable "app_port" { type = number }

variable "cognito_user_pool_domain" {
  description = "Cognito user pool domain for JWT authorizer"
  type        = string
}

variable "cognito_user_pool_client_id" {
  description = "Cognito user pool client ID for JWT authorizer"
  type        = string
}

