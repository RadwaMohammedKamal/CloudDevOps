resource "aws_eks_cluster" "this" {
  name     = "${var.environment}-eks"
  role_arn = var.eks_cluster_role_arn
  version  = var.eks_version

  vpc_config {
    subnet_ids              = var.private_subnets
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  enabled_cluster_log_types = ["api","audit","authenticator","controllerManager","scheduler"]
  tags       = var.tags
}

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

  tags       = var.tags
  depends_on = [aws_eks_cluster.this]
}


resource "aws_eks_fargate_profile" "this" {
  cluster_name           = aws_eks_cluster.this.name
  fargate_profile_name   = "${var.environment}-fargate"
  pod_execution_role_arn = var.fargate_pod_role_arn
  subnet_ids             = var.private_subnets

  selector { namespace = "fargate" }
  depends_on = [aws_eks_cluster.this]
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name      = aws_eks_cluster.this.name
  addon_name        = "vpc-cni"
  addon_version     = "v1.17.5-eksbuild.1"
  # resolve_conflicts = "OVERWRITE"
  depends_on        = [aws_eks_node_group.this]
  tags              = var.tags
}

resource "aws_eks_addon" "coredns" {
  cluster_name      = aws_eks_cluster.this.name
  addon_name        = "coredns"
  addon_version     = "v1.12.0-eksbuild.1"
  # resolve_conflicts = "OVERWRITE"
  depends_on        = [aws_eks_node_group.this]
  tags              = var.tags
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name      = aws_eks_cluster.this.name
  addon_name        = "kube-proxy"
  addon_version     = "v1.26.0-eksbuild.1"
  #  resolve_conflicts = "OVERWRITE"
  depends_on        = [aws_eks_node_group.this]
  tags              = var.tags
}
