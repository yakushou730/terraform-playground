provider "aws" {
  region = var.region
}

data "aws_vpc" "management_layer" {
  id = "vpc-0b960cde951801025"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_vpc_peering_connection" "my_vpc-management" {
  peer_vpc_id = data.aws_vpc.management_layer.id
  vpc_id      = aws_vpc.my_vpc.id
  auto_accept = true
}

resource "aws_security_group" "default" {
  name        = "Default SG"
  description = "Allow SSH access"
  vpc_id      = aws_vpc.my_vpc.id
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "public" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.my_vpc.id
}

module "crazy_foord" {
  source    = "./modules/application"
  vpc_id    = aws_vpc.my_vpc.id
  subnet_id = aws_subnet.public.id
  name      = "CrazyFoods ${module.mighty_trousers.hostname}"
}

module "mighty_trousers" {
  source      = "./modules/application"
  vpc_id      = aws_vpc.my_vpc.id
  subnet_id   = aws_subnet.public.id
  name        = "MightyTrousers"
  environment = var.environment
  extra_sgs   = [aws_security_group.default.id]
}
