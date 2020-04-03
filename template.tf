provider "aws" {
  region = var.region
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_security_group" "default" {
  name = "Default SG"
  description = "Allow SSH access"
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "public" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.my_vpc.id
}

module "crazy_foord" {
  source = "./modules/application"
  vpc_id = aws_vpc.my_vpc.id
  subnet_id = aws_subnet.public.id
  name = "CrazyFoods ${module.mighty_trousers.hostname}"
}

module "mighty_trousers" {
  source = "./modules/application"
  vpc_id = aws_vpc.my_vpc.id
  subnet_id = aws_subnet.public.id
  name = "MightyTrousers"
  environment = var.environment
  extra_sgs = [aws_security_group.default.id]
}
