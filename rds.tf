resource "aws_db_subnet_group" "db_subnet_groups" {
  name        = "rds_subnet_group"
  description = "Subnet group for RDS database"
  subnet_ids   = [aws_subnet.subnet3.id, aws_subnet.subnet4.id]
}


resource "aws_db_instance" "postgresql" {
  identifier             = "mydb"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgresql"
  engine_version         = "9.6"
  instance_class         = "db.t2.micro"
  db_name                = "nkabom"
  username               = "admin"
  password               = var.password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_groups.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  apply_immediately      = true
  skip_final_snapshot = true
}



