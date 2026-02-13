resource "aws_iam_role" "eks_cluster" {
  name = "${var.environment}-eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
  tags = var.tags
}
# manage cluster and call other service like nlb
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  for_each = toset(["AmazonEKSClusterPolicy","AmazonEKSServicePolicy"])
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/${each.key}"
}
# enable node to connect the cluster 
resource "aws_iam_role" "eks_node_group" {
  name = "${var.environment}-eks-node-group-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
  tags = var.tags
}
# enable node to connect the cluster and take ip from vpc and pull image
resource "aws_iam_role_policy_attachment" "eks_node_group_policy" {
  for_each = toset([
    "AmazonEKSWorkerNodePolicy",
    "AmazonEKS_CNI_Policy",
    "AmazonEC2ContainerRegistryReadOnly"
  ])
  role       = aws_iam_role.eks_node_group.name
  policy_arn = "arn:aws:iam::aws:policy/${each.key}"
}
# pull image to take logs to cloud watch
resource "aws_iam_role" "eks_fargate_pod" {
  name = "${var.environment}-eks-fargate-pod-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "eks-fargate-pods.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "eks_fargate_pod_policy" {
  role       = aws_iam_role.eks_fargate_pod.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}
