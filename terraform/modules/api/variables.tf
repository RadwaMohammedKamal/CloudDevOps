variable "environment" { type = string }
variable "vpc_id" { type = string }
variable "private_subnets" { type = list(string) }
variable "tags" { type = map(string) }
# variable "nlb_dns" {
#   description = "NLB DNS for API Gateway integration"
#   type        = string
# }
# variable "integration_uri" {
#   description = "URI for API integration (NLB DNS)"
#   type        = string
#   default     = ""
# }

variable "nlb_listener_arn" {
  description = "NLB Listener ARN for API Gateway integration"
  type        = string
  default     = ""
}

