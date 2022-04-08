locals {
  name = "${var.vpc_name}-${var.region}-vpc-new-one"

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