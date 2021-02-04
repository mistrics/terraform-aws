
variable "customer-code" {
  type = string
  description = "customer code to be used across resources."
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

variable "db-username" {
  type = string
  description = "RDS database username"
}

variable "db-password" {
  type = string
  description = "RDS database password"
}

variable "db-name" {
  type = string
  description = "RDS first database name"
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