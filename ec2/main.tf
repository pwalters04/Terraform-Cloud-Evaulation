//
//data "aws_vpc" "vpc"{
//  filter {
//    name = "tag:Name"
//    values = ["eks-vpc"]
//  }
//}
//
//data "aws_security_group" "selected" {
//  filter {
//    name = "tag:Name"
//    values = ["demo-cluster-cluster"]
//  }
//}
//
//data "aws_subnet_ids" "subnet"{
//  vpc_id = data.aws_vpc.vpc.id
//  filter {
//    name = "tag:Name"
//    values = ["eks-vpc-private-us-east-1a"]
//  }
//}
//
//
//module "ec2_instance" {
//  source  = "terraform-aws-modules/ec2-instance/aws"
//  version = "~> 3.0"
//
//  name = "single-instance"
//
//  ami                    = "ami-0c02fb55956c7d316"
//  instance_type          = "t2.micro"
//  monitoring             = true
//  vpc_security_group_ids = ["sg-03fa3d50ea179ad8f"]
//  subnet_id              = "subnet-023aeca8a04af0af5"
//
//  tags = {
//    Terraform   = "true"
//    Environment = "dev"
//  }
//}