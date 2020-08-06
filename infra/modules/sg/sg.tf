resource "aws_security_group" "ssh" {
  name = "ssh"
  description = "Allow inbound SSH traffic"
  vpc_id = var.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh"
  }
}

resource "aws_security_group" "internet" {
  name = "internet"
  description = "Allow outbound traffic"
  vpc_id = var.vpc_id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "internet"
  }
}


output "sg_ssh_id" {
  value = aws_security_group.ssh.id
}

output "sg_internet_id" {
  value = aws_security_group.internet.id
}
