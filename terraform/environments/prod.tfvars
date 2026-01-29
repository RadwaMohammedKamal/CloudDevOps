region      = "eu-north-1"
environment = "prod"

vpc_cidr = "10.20.0.0/16"

azs = ["eu-north-1a", "eu-north-1b"]

public_subnet_cidrs  = ["10.20.1.0/24", "10.20.2.0/24"]
private_subnet_cidrs = ["10.20.11.0/24", "10.20.12.0/24"]
data_subnet_cidrs    = ["10.20.21.0/24", "10.20.22.0/24"]

tags = {
  env     = "prod"
  project = "CloudDevOps"
}
