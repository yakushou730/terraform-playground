variable "environment" { default = "dev" }
variable "instance_type" {
  type = map(string)
  default = {
    dev = "t2.micro"
    test = "t2.medium"
    prod = "t2.large"
  }
}
