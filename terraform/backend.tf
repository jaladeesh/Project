terraform {
  backend "s3" {
    bucket         = "terraform-backend0408"
    key            = "terraform/state.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "terraform-dynamo-db-lock"  # Optional, for state locking
  }
}
