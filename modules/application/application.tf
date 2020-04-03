variable "vpc_id" {}
variable "subnet_id" {}
variable "name" {}

resource "aws_security_group" "allow_http" {
  name = "${var.name} allow_http"
  description = "Allow HTTP traffic"
  vpc_id = var.vpc_id
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app-server" {
  ami           = "ami-07f4cb4629342979c"
  instance_type = lookup(var.instance_type, var.environment )
  subnet_id = var.subnet_id
  vpc_security_group_ids = distinct(concat(var.extra_sgs, aws_security_group.allow_http.*.id))
  tags = {
    Name = var.name
  }
}

output "hostname" {
  value = aws_instance.app-server.private_dns
}
