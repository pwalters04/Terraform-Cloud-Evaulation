locals {
  name = "${var.vpc_name}${var.region}-vpc-new"

}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = local.name
  cidr = var.cidr

  azs              = ["${var.region}a", "${var.region}b", "${var.region}c"]
  public_subnets   = var.public_subnet
  private_subnets  = var.private_subnet
  tags = {
    Deployment=var.sources
    Env = "Demo"
  }
}

output "vpc-private-subnets" {
  value = module.vpc.private_subnets
}

output "vpc-id" {
  value = module.vpc.vpc_id
}