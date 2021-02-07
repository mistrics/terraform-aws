
variable "customer-code" {
  type = string
  description = "customer code to be used across resources."
}

variable "environment" {
  type = string
  description = "Name of the target environment, ex. Dev, Prod etc."
}

variable "access-key" {
  type = string
}

variable "secret-key" {
  type = string
}

variable "region" {
  type = string
}

variable "azs" {
  type = string
  description = "List of availability zones"
}


variable "public-key" {
  type = string
  description = "Server Public Key"
}

variable "instance-type" {
  type = string
  default = "t2.micro"
}

variable "instance-ami" {
  type = string
}