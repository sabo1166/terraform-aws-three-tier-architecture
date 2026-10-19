variable "name" {
  type        = string
  description = "Resource name prefix"
}

variable "alb_dns_name" {
  type        = string
  description = "ALB DNS hostname used as CloudFront origin"
}
