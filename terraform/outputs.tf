output "vpc_id" {
  value = module.vpc.vpc_id
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_role_arn" {
  value = module.iam.eks_cluster_role_arn
}

output "node_group_role_arn" {
  value = module.iam.eks_node_group_role_arn
}

output "fargate_pod_execution_role_arn" {
  value = module.iam.eks_fargate_pod_execution_role_arn
}
