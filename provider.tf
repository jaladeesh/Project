provider "aws" {
  region = var.aws_region
  shared_config_files      = ["/home/ubuntu/.aws/conf"]
  shared_credentials_files = ["/home/ubuntu/.aws/creds"]
  profile = "default"
}