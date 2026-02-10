variable "environment" { type = string }
variable "vpc_id" { type = string }
variable "private_subnets" { type = list(string) }
variable "tags" { type = map(string) }

variable "integration_uri" {
  description = "URI for API integration (NLB DNS)"
  type        = string
  default     = ""
}

variable "argocd_ingress_dns" {
  description = "DNS of the Argo CD ingress"
  type        = string
}


# variable "environment" { type = string }
# variable "vpc_id" { type = string }
# variable "public_subnets" { type = list(string) }
# variable "app_port" { type = number }
# variable "tags" { type = map(string) }
# variable "region" { type = string }
