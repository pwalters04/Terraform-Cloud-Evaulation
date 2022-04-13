terraform {
  required_version = ">=1.1.0"

  cloud {
    organization = "VeloCloud-Terraform"

    workspaces {
      name = "apps-test-us-east-1-eks"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 2.2"
    }
  }
}