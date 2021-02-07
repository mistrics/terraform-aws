
resource "aws_s3_bucket" "source-bucket" {
  bucket = "${var.customer-code}-source-bucket"
  acl    = "private"

  tags = {
    Name        = "${var.customer-code}-source-bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "source-bucket-access" {
  bucket = aws_s3_bucket.source-bucket.id

  block_public_acls   = true
  block_public_policy = true
}

resource "aws_efs_file_system" "efs" {
  creation_token = "${var.customer-code}-my-product"
  
  tags = {
    Name = "${var.customer-code}-MyProduct"
  }
}

resource "aws_efs_mount_target" "mount" {
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.web_security_group.id]
}


