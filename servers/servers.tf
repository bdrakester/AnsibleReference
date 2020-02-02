provider "aws" {
  profile = "my_aws"
  region = var.aws_region
}

resource "aws_key_pair" "AnsibleRef-keypair" {
  key_name = "AnsibleRef-keypair"
  public_key = file("id_centos.pub")
}

resource "aws_security_group" "AnsibleRef-SG-Base" {
  name = "AnsibleRef-SG-Base"
  description = "Base SG Allow SSH in, HTTP/s out"
  vpc_id = var.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "107.0.8.124/32", "73.70.39.36/32"]
    description = "Allow SSH"
  }

  egress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0"]
    description = "Allow HTTPS"
  }

  egress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0"]
    description = "Allow HTTP"
  }

  tags = {
    Name = "AnsibleRef-SG-Base"
  }
}

resource "aws_instance" "AnsibleRef-Web1" {
  ami = "ami-074e2d6769f445be5"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.AnsibleRef-SG-Base.id]
  subnet_id = var.subnet_id
  key_name = aws_key_pair.AnsibleRef-keypair.key_name
  associate_public_ip_address = true

  root_block_device {
    delete_on_termination = true
  }

  tags = {
    Name = "AnsibleRef-Web1"
  }
}

resource "aws_instance" "AnsibleRef-Web2" {
  ami = "ami-074e2d6769f445be5"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.AnsibleRef-SG-Base.id]
  subnet_id = var.subnet_id
  key_name = aws_key_pair.AnsibleRef-keypair.key_name
  associate_public_ip_address = true

  root_block_device {
    delete_on_termination = true
  }

  tags = {
    Name = "AnsibleRef-Web2"
  }
}

resource "aws_instance" "AnsibleRef-Database" {
  ami = "ami-074e2d6769f445be5"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.AnsibleRef-SG-Base.id]
  subnet_id = var.subnet_id
  key_name = aws_key_pair.AnsibleRef-keypair.key_name
  associate_public_ip_address = true

  root_block_device {
    delete_on_termination = true
  }

  tags = {
    Name = "AnsibleRef-Database"
  }
}

# Create Ansible Inventory file
resource "null_resource" "create_inventory" {
  depends_on = [ aws_instance.AnsibleRef-Web1, aws_instance.AnsibleRef-Web2, aws_instance.AnsibleRef-Database]
  provisioner "local-exec" {
    command = <<-EOF
	echo '[webservers]
	${aws_instance.AnsibleRef-Web1.public_ip}
	${aws_instance.AnsibleRef-Web2.public_ip}
	[databases]
	${aws_instance.AnsibleRef-Database.public_ip}' > ./ansible/inventory.ini
    EOF
  }
}


