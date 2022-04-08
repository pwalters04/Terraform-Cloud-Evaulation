locals {
  vpc-name = "apps-test-${var.region}-vpc-new"
}

data "aws_vpc" "vpc"{
  filter {
    name = "tag:Name"
    values = ["${local.vpc-name}"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Type"
    values = ["Private"]
  }
}

data "aws_subnet" "private" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.value
}

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.private : s.cidr_block]
}

output "vpc-id" {
  value = data.aws_vpc.vpc.id
}
output "subnet-info" {
  value = data.aws_subnets.private.id
}