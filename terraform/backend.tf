terraform {
  backend "s3" {
    bucket = "cloud-devops-nti-s3"
    key    = "terraform/terraform.tfstate"
    region = "eu-north-1"
    encrypt = true
  }
}
