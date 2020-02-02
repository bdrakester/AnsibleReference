output "VPC_id" {
  value = aws_vpc.AnsibleRef-VPC.id
}

output "Subnet_id" {
  value = aws_subnet.AnsibleRef-Subnet.id
}