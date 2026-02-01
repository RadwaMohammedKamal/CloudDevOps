module "vpc" {
  source               = "./modules/vpc"
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  data_subnet_cidrs    = var.data_subnet_cidrs
  tags                 = var.tags
  app_port             = var.app_port
}

module "iam" {
  source      = "./modules/iam"
  environment = var.environment
  tags        = var.tags
}

module "eks" {
  source                  = "./modules/eks"
  environment             = var.environment
  private_subnets         = module.vpc.private_subnet_ids
  eks_cluster_role_arn    = module.iam.eks_cluster_role_arn
  node_group_role_arn     = module.iam.eks_node_group_role_arn
  fargate_pod_role_arn    = module.iam.eks_fargate_pod_role_arn
  eks_nodes_sg_id         = module.vpc.eks_nodes_sg_id
  tags                    = var.tags
}
