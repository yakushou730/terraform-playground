provider "aws" {
  region = var.region
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
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
}
