# Provider configuration
provider "aws" {
  region = "ap-northeast-1"
}

# Resource configuration
resource "aws_instance" "hello-instance" {
  ami           = "ami-07f4cb4629342979c"
  instance_type = "t2.micro"
  tags = {
    Name = "hello-instance"
  }
}
