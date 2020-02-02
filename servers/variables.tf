variable "aws_region" {
  type = string
  description = "The AWS region"
}

variable "vpc_id" {
  type = string
  description = "The ID of the VPC"
}

variable "subnet_id" {
  type = string
  description = "The ID of the subnet the servers should be in"
}

