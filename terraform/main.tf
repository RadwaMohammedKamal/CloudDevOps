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

module "ecr" {
  source       = "./modules/ecr"
  environment  = var.environment
  repositories = ["vote", "result", "worker"]
  tags         = var.tags
}

module "ssm" {
  source       = "./modules/ssm"
  environment  = var.environment
  mongodb_uri  = "placeholder"
  tags         = var.tags
}

module "irsa" {
  source       = "./modules/irsa"
  environment  = var.environment
  cluster_name = module.eks.cluster_name

  depends_on = [module.eks]
}

module "api" {
  source         = "./modules/api"
  environment    = var.environment
  public_subnets = module.vpc.public_subnet_ids
  vpc_id         = module.vpc.vpc_id
  app_port       = var.app_port
  tags           = var.tags
  cognito_user_pool_domain    = var.cognito_user_pool_domain
  cognito_user_pool_client_id = var.cognito_user_pool_client_id
}

resource "aws_security_group_rule" "allow_alb_to_nodes" {
  type                     = "ingress"
  from_port                = var.app_port
  to_port                  = var.app_port
  protocol                 = "tcp"
  security_group_id        = module.vpc.eks_nodes_sg_id
  source_security_group_id = module.api.alb_sg_id
}
