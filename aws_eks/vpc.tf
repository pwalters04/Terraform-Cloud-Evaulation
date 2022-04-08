locals {
  vpc-name = "apps-test-${var.region}-vpc-new"
}

data "aws_vpc" "vpc"{
  filter {
    name = "tag:Name"
    values = ["${local.vpc-name}"]
  }
}

output "vpc-id" {
  value = data.aws_vpc.vpc.id
}