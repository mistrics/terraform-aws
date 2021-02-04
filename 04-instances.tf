

# # data "aws_ami" "ubuntu" {
# #   most_recent = true

# #   filter {
# #     name   = "name"
# #     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
# #   }

# #   filter {
# #     name   = "virtualization-type"
# #     values = ["hvm"]
# #   }

# #   owners = ["099720109477"] # Canonical
# # }

# resource "aws_key_pair" "key-pair" {
#   key_name   = "${var.customer-code}-key-pair"
#   public_key = var.public-key
# }


# resource "aws_instance" "web" {
#   ami           = var.instance-ami
#   instance_type = "t2.micro"
#   subnet_id = aws_subnet.public_subnet.id
#   security_groups = [ aws_security_group.web_security_group.id ]
#   key_name = "${var.customer-code}-key-pair"
#   associate_public_ip_address = true
  
#   user_data = templatefile("${path.module}/instance-config.sh", {
#     DB_HOST = "Devendra" #aws_db_instance.database.address
#     DB_USERNAME = "Is" #var.db-username
#     DB_PASSWORD = "Happy" #var.db-password
#     DB_NAME = "WhatElse" #var.db-name
#   })

#   tags = {
#     Name = "${var.customer-code}-WebServer"
#   }
# }