variable "environment" { type = string }
variable "eks_cluster_role_arn" { type = string }
variable "node_group_role_arn" { type = string }
variable "fargate_pod_role_arn" { type = string }
variable "eks_version" {
  type    = string
  default = "1.32"
}
variable "private_subnets" { type = list(string) }
variable "eks_nodes_sg_id" { type = string }
variable "tags" { type = map(string)}
