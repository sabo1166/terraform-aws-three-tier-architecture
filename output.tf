output "cloudfront_url" {
  description = "HTTPS URL for the application through CloudFront"
  value       = "https://${module.cloudfront.domain_name}"
}

output "alb_dns_name" {
  description = "ALB origin hostname"
  value       = module.alb.dns_name
}

output "ec2_private_ips" {
  description = "Private IP addresses of both EC2 instances"
  value       = module.ec2.private_ips
}

output "rds_endpoint" {
  description = "RDS endpoint hostname (not publicly accessible)"
  value       = module.rds.endpoint
}

output "s3_bucket_name" {
  description = "Private S3 bucket name"
  value       = module.s3.bucket_name
}
