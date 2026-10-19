variable "aws_region" {
  description = "AWS region for this deployment"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Short project name used in resource names"
  type        = string
  default     = "terraform-1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "db_name" {
  description = "Initial MySQL database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "appadmin"
}

variable "db_password" {
  description = "RDS master password; provide through TF_VAR_db_password or a local ignored tfvars file"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "ec2_instance_type" {
  description = "EC2 instance type for the Nginx servers"
  type        = string
  default     = "t3.micro"
}

variable "allowed_admin_cidr" {
  description = "Optional admin IP CIDR for future access; not used to expose EC2 or ALB directly"
  type        = string
  default     = ""
}
