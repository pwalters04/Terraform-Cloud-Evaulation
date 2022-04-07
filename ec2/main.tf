
data "aws_vpc" "vpc"{
  filter {
    name = "tag:Name"
    values = ["eks-vpc"]
  }
}

data "aws_security_group" "selected" {
  filter {
    name = "tag:Name"
    values = ["demo-cluster-cluster"]
  }
}

data "aws_subnet_ids" "subnet"{
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name = "tag:Name"
    values = ["eks-vpc-private-us-east-1a"]
  }
}


module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = "ami-ebd02392"
  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = [data.aws_security_group.selected.id]
  subnet_id              = data.aws_subnet_ids.subnet.id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
