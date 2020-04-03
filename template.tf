# Provider configuration
provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_instance" "master-instance" {
  ami           = "ami-07f4cb4629342979c"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public.id
  tags = {
    Name = "master-instance"
  }
}

resource "aws_instance" "slave-instance" {
  ami           = "ami-07f4cb4629342979c"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public.id
  tags = {
    master_hostname = aws_instance.master-instance.private_dns
    Name = "slave-instance"
  }
  depends_on = [aws_instance.master-instance]
  lifecycle {
    ignore_changes = [tags]
  }
}

