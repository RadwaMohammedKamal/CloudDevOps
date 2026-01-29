# VPC Module
module "vpc" {
  source               = "./modules/vpc"
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  data_subnet_cidrs    = var.data_subnet_cidrs
  tags                 = var.tags
}

# # EKS Module
# module "eks" {
#   source          = "./modules/eks"
#   environment     = var.environment
#   vpc_id          = module.vpc.vpc_id
#   private_subnets = module.vpc.private_subnet_ids
#   tags            = var.tags
# }
