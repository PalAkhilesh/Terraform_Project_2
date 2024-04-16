###################################
# region us-east-1
###################################
terraform {
  required_providers {
    aws = ">= 2.0"
  }
}

provider "aws" {
  alias      = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-east-1"
}