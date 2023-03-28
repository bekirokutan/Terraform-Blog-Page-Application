resource "aws_db_instance" "capstone_rds" {
  allocated_storage      = 20
  db_name                = var.dataname
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = "db.t2.micro"
  username               = var.datauser
  password               = var.datapass
  port                   = 3306
  identifier             = "blog-terraform"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds-seg.id]
  db_subnet_group_name   = aws_db_subnet_group.rdssubnet.name
}