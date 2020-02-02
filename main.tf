terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  profile = "my_aws"
  region = var.aws_region
}

module "AnsibleRef-Network" {
  source = "./vpc"
  aws_region = var.aws_region
}

module "AnsibleRef-Servers" {
  source = "./servers"

  vpc_id = module.AnsibleRef-Network.VPC_id
  subnet_id = module.AnsibleRef-Network.Subnet_id
  aws_region = var.aws_region
}