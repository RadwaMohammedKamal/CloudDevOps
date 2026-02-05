region      = "eu-north-1"
environment = "nonprod"

vpc_cidr = "10.10.0.0/16"

azs = ["eu-north-1a","eu-north-1b"]

public_subnet_cidrs = ["10.10.1.0/24","10.10.2.0/24"]
private_subnet_cidrs = ["10.10.11.0/24","10.10.12.0/24"]
data_subnet_cidrs = ["10.10.21.0/24","10.10.22.0/24"]

tags = {
  env     = "nonprod"
  project = "CloudDevOps"
}
app_port = 8080


