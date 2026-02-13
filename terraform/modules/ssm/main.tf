resource "aws_ssm_parameter" "mongodb_uri" {
  name  = "/${var.environment}/mongodb/uri"
  type  = "SecureString"
  value = var.mongodb_uri
  tags = var.tags
}
# store secrets of ssm paramiters