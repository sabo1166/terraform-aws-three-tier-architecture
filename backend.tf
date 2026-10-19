
terraform {
  backend "s3" {
    bucket       = "moh-terraform-state-2026-unique"
    key          = "aws-three-tier/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
