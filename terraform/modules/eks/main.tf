########################
# EKS Cluster
########################
resource "aws_eks_cluster" "this" {
  name     = "${var.environment}-eks"
  role_arn = var.eks_cluster_role_arn
  version  = var.eks_version

  vpc_config {
    subnet_ids              = var.private_subnets
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator"
  ]

  tags = var.tags
}

########################
# Managed Node Group
########################
resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.environment}-ng"
  node_role_arn   = var.node_group_role_arn
  subnet_ids      = var.private_subnets

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  instance_types = ["t3.small"]
  capacity_type  = "ON_DEMAND"

  tags = var.tags

  depends_on = [
    aws_eks_cluster.this
  ]
}

########################
# Fargate Profile (Design Only)
########################
resource "aws_eks_fargate_profile" "this" {
  cluster_name           = aws_eks_cluster.this.name
  fargate_profile_name   = "${var.environment}-fargate"
  pod_execution_role_arn = var.fargate_pod_execution_role_arn
  subnet_ids             = var.private_subnets

  # NOT USED NOW – for future microservices
  selector {
    namespace = "fargate"
  }

  depends_on = [
    aws_eks_cluster.this
  ]
}

########################
# EKS Addons
########################
resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "vpc-cni"

  depends_on = [
    aws_eks_node_group.this
  ]
}

resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "coredns"

  depends_on = [
    aws_eks_node_group.this
  ]
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "kube-proxy"

  depends_on = [
    aws_eks_node_group.this
  ]
}



# # EKS Cluster
# resource "aws_eks_cluster" "this" {
#   name     = "${var.environment}-eks"
#   role_arn = var.eks_cluster_role_arn
#   version  = var.eks_version

#   vpc_config {
#     subnet_ids              = var.private_subnets
#     endpoint_private_access = true
#     endpoint_public_access  = true
#   }

#   enabled_cluster_log_types = ["api", "audit", "authenticator"]

#   tags       = var.tags
# }

# # Fargate Profile
# resource "aws_eks_fargate_profile" "this" {
#   cluster_name           = aws_eks_cluster.this.name
#   fargate_profile_name   = "${var.environment}-fargate"
#   pod_execution_role_arn = var.fargate_pod_execution_role_arn
#   subnet_ids             = var.private_subnets

#   selector {
#     namespace = "fargate"
#   }

#   depends_on = [aws_eks_cluster.this]
# }

# # Managed Node Group
# resource "aws_eks_node_group" "this" {
#   cluster_name    = aws_eks_cluster.this.name
#   node_group_name = "${var.environment}-ng"
#   node_role_arn   = var.node_group_role_arn
#   subnet_ids      = var.private_subnets

#   scaling_config {
#     desired_size = 2
#     min_size     = 1
#     max_size     = 3
#   }

#   instance_types = ["t3.small"]
#   capacity_type  = "ON_DEMAND"

#   tags = var.tags
# }

# # Addons
# resource "aws_eks_addon" "vpc_cni" {
#   cluster_name  = aws_eks_cluster.this.name
#   addon_name    = "vpc-cni"
# }

# resource "aws_eks_addon" "coredns" {
#   cluster_name = aws_eks_cluster.this.name
#   addon_name   = "coredns"
# }

# resource "aws_eks_addon" "kube_proxy" {
#   cluster_name = aws_eks_cluster.this.name
#   addon_name   = "kube-proxy"
# }
