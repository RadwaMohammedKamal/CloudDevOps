# # IAM Role for EKS Cluster
# resource "aws_iam_role" "eks" {
#   name = "${var.environment}-eks-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Effect    = "Allow"
#       Principal = { Service = "eks.amazonaws.com" }
#       Action    = "sts:AssumeRole"
#     }]
#   })

#   tags = var.tags
# }

# resource "aws_iam_role_policy_attachment" "eks_managed" {
#   for_each = toset([
#     "AmazonEKSClusterPolicy",
#     "AmazonEKSServicePolicy"
#   ])
#   role       = aws_iam_role.eks.name
#   policy_arn = "arn:aws:iam::aws:policy/${each.key}"
# }

# # IAM Role for Node Group
# resource "aws_iam_role" "node_group" {
#   name = "${var.environment}-eks-node-group-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Effect    = "Allow"
#       Principal = { Service = "ec2.amazonaws.com" }
#       Action    = "sts:AssumeRole"
#     }]
#   })

#   tags = var.tags
# }

# resource "aws_iam_role_policy_attachment" "node_group_managed" {
#   for_each = toset([
#     "AmazonEKSWorkerNodePolicy",
#     "AmazonEKS_CNI_Policy",
#     "AmazonEC2ContainerRegistryReadOnly"
#   ])
#   role       = aws_iam_role.node_group.name
#   policy_arn = "arn:aws:iam::aws:policy/${each.key}"
# }
