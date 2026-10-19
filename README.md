# Terraform-1: CloudFront + ALB + EC2 + RDS + S3

This project provisions a two-AZ AWS architecture:
- CloudFront distribution with HTTPS for viewers.
- Public Application Load Balancer across two public subnets.
- Two Amazon Linux 2023 EC2 instances in private app subnets; Nginx is installed using `user_data`.
- One NAT Gateway for private-subnet outbound internet access.
- Private RDS MySQL in a DB subnet group spanning two AZs.
- Private, encrypted S3 bucket with Block Public Access.
- Security groups restrict app traffic to the ALB and database traffic to the app tier.

## Important design notes
- CloudFront viewer connections use HTTPS. The CloudFront-to-ALB origin connection is HTTP in this starter because no domain/ACM certificate was supplied. For production, configure a domain and an ACM certificate in the ALB region, then switch the CloudFront origin to HTTPS.
- The single NAT Gateway is a cost-saving choice, not fully AZ-resilient. Instances in the other AZ route outbound traffic through it.
- NAT Gateway, ALB, EC2, RDS and CloudFront can incur charges. Review the plan and AWS pricing before applying.
- The S3 bucket is separate private storage; this starter does not configure application uploads or an S3 CloudFront origin.
- RDS password is supplied through `TF_VAR_db_password`; do not commit secrets.

## Windows PowerShell: validate only (no resources created)
```powershell
$env:TF_VAR_db_password = "Use-A-Strong-Unique-Password-Here"
terraform init
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
```

Review `terraform plan` carefully. `plan` does not create infrastructure. Do not run `terraform apply` until you explicitly decide to deploy.

When finished with the local shell:
```powershell
Remove-Item Env:TF_VAR_db_password
```
