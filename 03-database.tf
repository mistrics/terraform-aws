

resource "aws_db_subnet_group" "db-subnet-group" {
  name       = lower("${var.customer-code}-DB-Subnet-Group")
  subnet_ids = aws_subnet.private_subnet.*.id

  tags = {
    Name = lower("${var.customer-code}-DB-Subnet-Group")
  }
}

resource "aws_db_instance" "database" {
  identifier = lower("${var.customer-code}-DB")
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = var.db-name
  username             = var.db-username
  password             = var.db-password
  parameter_group_name = "default.mysql5.7"
  vpc_security_group_ids = [ aws_security_group.web_security_group.id ]
  db_subnet_group_name = aws_db_subnet_group.db-subnet-group.name
  publicly_accessible = true
  final_snapshot_identifier = "${var.customer-code}-DB-Snapshot"
  character_set_name = "utf8"
  # skip_final_snapshot = true
  tags = {
    "Name" = "${var.customer-code}-DB"
  }
}