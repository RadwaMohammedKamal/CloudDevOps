variable "region" { type = string }
variable "environment" { type = string }
variable "vpc_cidr" { type = string }
variable "azs" { type = list(string) }
variable "public_subnet_cidrs" { type = list(string) }
variable "private_subnet_cidrs" { type = list(string) }
variable "data_subnet_cidrs" { type = list(string) }
variable "tags" { type = map(string) }
variable "app_port" {
  type = number
}
variable "mongodb_uri" {
  type = string
}
variable "integration_uri" {
  description = "URI for API integration (NLB DNS)"
  type        = string
  default     = ""
}


# variable "region" { type = string }
# variable "environment" { type = string }
# variable "vpc_cidr" { type = string }
# variable "azs" { type = list(string) }
# variable "public_subnet_cidrs" { type = list(string) }
# variable "private_subnet_cidrs" { type = list(string) }
# variable "data_subnet_cidrs" { type = list(string) }
# variable "tags" { type = map(string)}
# variable "app_port" {
#   description = "Port used by the application"
#   type        = number
# }

# variable "mongodb_uri" {
#   description = "MongoDB connection string"
#   type        = string
# }
