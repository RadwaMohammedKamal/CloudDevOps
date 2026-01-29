# #  IAM module
# module "iam" {
#   source      = "../iam"
#   environment = var.environment
#   tags        = var.tags
# }

# # EKS Cluster
# resource "aws_eks_cluster" "this" {
#   name     = "${var.environment}-eks"
#   role_arn = module.iam.eks_role_arn

#   vpc_config {
#     subnet_ids = var.private_subnets
#   }

#   tags = var.tags
# }

# # EKS Fargate Profile
# resource "aws_eks_fargate_profile" "this" {
#   cluster_name = aws_eks_cluster.this.name
#   fargate_profile_name = "${var.environment}-fargate"

#   pod_execution_role_arn = module.iam.node_group_role_arn
#   subnet_ids             = var.private_subnets

#   selector {
#     namespace = "default"
#   }
# }
