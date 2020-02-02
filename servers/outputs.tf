output "AnsibleRef-Web1_public-ip" {
  value = aws_instance.AnsibleRef-Web1.public_ip
}

output "AnsibleRef-Web2_public-ip" {
  value = aws_instance.AnsibleRef-Web2.public_ip
}

output "AnsibleRef-Database_public-ip" {
  value = aws_instance.AnsibleRef-Database.public_ip
}

