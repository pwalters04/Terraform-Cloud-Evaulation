terraform {
  cloud {
    organization = "VeloCloud-Terraform"

    workspaces {
      name = "Shared_Service_Playground_us-east-1_ec2"
    }
  }
}

terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.72"
    }
  }
}

provider "aws" {
  region = var.region
}