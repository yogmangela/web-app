terraform {
  required_version = "> 1.3.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "web-app-state-storage"
    key    = "web-app/hello-world/hello-world.tfstate"
    region = "eu-west-2"
  }
  #  S3 bucket for storage: web-app-state-storage
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}