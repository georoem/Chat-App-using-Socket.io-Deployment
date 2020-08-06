resource "aws_instance" "instance_1" {
  subnet_id     = var.subnet_ids[0]
  ami           = "ami-07df16d0682f1fa59" //Ubuntu 18.04 LTS
  instance_type = "t2.micro"
  security_groups = var.sg_ids
  key_name = var.key_pair_name
  associate_public_ip_address = true
  tags = {
    Name = format("%s-%s-%s", var.project, var.environment, "ec2-1")
  }
}

resource "aws_instance" "instance_2" {
  subnet_id     = var.subnet_ids[1]
  ami           = "ami-07df16d0682f1fa59" //Ubuntu 18.04 LTS
  instance_type = "t2.micro"
  security_groups = var.sg_ids
  key_name = var.key_pair_name
  associate_public_ip_address = true
  tags = {
    Name = format("%s-%s-%s", var.project, var.environment, "ec2-2")
  }
}

output "instance_ids" {
  value = [aws_instance.instance_1.id, aws_instance.instance_2.id]
}