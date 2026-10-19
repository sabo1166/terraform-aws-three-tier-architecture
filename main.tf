locals {
  name = "${var.project_name}-${var.environment}"
}

module "network" {
  source     = "./modules/network"
  name       = local.name
  aws_region = var.aws_region
}

module "alb" {
  source            = "./modules/alb"
  name              = local.name
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
}

module "ec2" {
  source                = "./modules/ec2"
  name                  = local.name
  vpc_id                = module.network.vpc_id
  private_subnet_ids    = module.network.private_app_subnet_ids
  alb_security_group_id = module.alb.security_group_id
  instance_type         = var.ec2_instance_type
}

resource "aws_lb_target_group_attachment" "app" {
  count            = length(module.ec2.instance_ids)
  target_group_arn = module.alb.target_group_arn
  target_id        = module.ec2.instance_ids[count.index]
  port             = 80
}

module "rds" {
  source                = "./modules/rds"
  name                  = local.name
  vpc_id                = module.network.vpc_id
  private_db_subnets    = module.network.private_db_subnet_ids
  app_security_group_id = module.ec2.security_group_id
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  db_instance_class     = var.db_instance_class
}

module "s3" {
  source = "./modules/s3"
  name   = local.name
}

module "cloudfront" {
  source       = "./modules/cloudfront"
  name         = local.name
  alb_dns_name = module.alb.dns_name
}

# output "alb_dns_name" {
#   description = "ALB DNS name (origin endpoint)"
#   value       = module.alb.dns_name
# }

# output "cloudfront_domain_name" {
#   description = "CloudFront distribution domain name"
#   value       = module.cloudfront.domain_name
# }

# output "ec2_private_ips" {
#   description = "Private IP addresses of the Nginx instances"
#   value       = module.ec2.private_ips
# }

# output "rds_endpoint" {
#   description = "RDS endpoint hostname"
#   value       = module.rds.endpoint
# }

# output "s3_bucket_name" {
#   description = "Private S3 bucket name"
#   value       = module.s3.bucket_name
# }
