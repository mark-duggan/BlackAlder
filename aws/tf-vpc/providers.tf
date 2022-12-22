terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  backend "s3" {
    bucket = "duggan-xyz-automation-1"
    key = "tf-vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  region  = var.aws_region
}