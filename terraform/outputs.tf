output "vpc_id" { value = module.vpc.vpc_id }
output "public_subnets" { value = module.vpc.public_subnet_ids }
output "private_subnets" { value = module.vpc.private_subnet_ids }
output "eks_nodes_sg_id" { value = module.vpc.eks_nodes_sg_id }

output "eks_cluster_name" { value = module.eks.cluster_name }
output "eks_cluster_endpoint" { value = module.eks.cluster_endpoint }
output "eks_cluster_arn" { value = module.eks.cluster_arn }
output "eks_node_group_name" { value = module.eks.node_group_name }
output "eks_fargate_profile_name" { value = module.eks.fargate_profile_name }

output "eks_cluster_role_arn" { value = module.iam.eks_cluster_role_arn }
output "eks_node_group_role_arn" { value = module.iam.eks_node_group_role_arn }
output "eks_fargate_pod_role_arn" { value = module.iam.eks_fargate_pod_role_arn }
