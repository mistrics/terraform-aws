
# resource "aws_launch_template" "launch-template" {
#   name_prefix   = "${var.customer-code}-server"
#   image_id      = var.instance-ami
#   instance_type = var.instance-type
#   vpc_security_group_ids = [ aws_security_group.web_security_group.id ]
# }

# data "template_file" "instance-script" {
#   template = file("${path.cwd}/instance-config.sh")
#   vars = {
#     DB_HOST = aws_db_instance.main_rds_instance.address
#     DB_USERNAME = var.db-username
#     DB_PASSWORD = var.db-password
#     Db_NAME = var.db-name
#   } 
# }


resource "aws_key_pair" "key-pair" {
  key_name   = "${var.customer-code}-key-pair"
  public_key = var.public-key
}

resource "aws_launch_configuration" "launch-config" {
  name          = "${var.customer-code}-Launch-Config"
  image_id      = var.instance-ami
  instance_type = var.instance-type
  security_groups = [ aws_security_group.web_security_group.id ]
  key_name = "${var.customer-code}-key-pair"
  associate_public_ip_address = true
  user_data = templatefile("${path.module}/instance-config.sh", {
    DB_HOST = aws_db_instance.database.address
    DB_USERNAME = var.db-username
    DB_PASSWORD = var.db-password
    DB_NAME = var.db-name
  })
}

resource "aws_autoscaling_group" "auto-scaling-group" {
  //availability_zones = split(",", var.azs)
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  launch_configuration = aws_launch_configuration.launch-config.id
  vpc_zone_identifier = [aws_subnet.public_subnet.id]


#   launch_template {
#     id      = aws_launch_template.launch-template.id
#     version = "$Latest"
#   }
}


# Create a new load balancer attachment
resource "aws_autoscaling_attachment" "attach-load-balancer" {
  autoscaling_group_name = aws_autoscaling_group.auto-scaling-group.id
  elb                    = aws_elb.load-balancer.id
}
