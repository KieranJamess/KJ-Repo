terraform {
  backend "s3" {
    bucket         = "kjtestbucketnew"
    key            = "KJTest/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = "true"
  }
  required_providers {
    aws = "~> 2.44"
  }
}
