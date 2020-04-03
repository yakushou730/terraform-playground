variable "region" {
  description = "AWS region. Changing it will lead to loss of complete stack."
  default = "ap-northeast-1"
}

variable "environment" { default = "prod" }
