terraform {
  required_version = ">=1.1.0"

  cloud {
    organization = "VeloCloud-Terraform"

    workspaces {
      name = "apps-test-us-east-1"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.72.0"
    }
  }
}

provider "aws" {
  region = var.region
}
