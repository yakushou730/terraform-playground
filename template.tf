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
