locals {
  vcp-name = "${var.vpc_name}-${var.region}-vpc-new"
}


data "aws_vpc" "vpc"{
  filter {
    name = "tag:Name"
    values = ["${local.vcp-name}"]
  }
}