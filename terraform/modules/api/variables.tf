variable "environment" { type = string }
variable "vpc_id" { type = string }
variable "public_subnets" { type = list(string) }
variable "app_port" { type = number }
variable "tags" { type = map(string) }
variable "region" { type = string }
