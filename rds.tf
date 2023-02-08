resource "aws_db_subnet_group" "db_subnet_groups" {
  name        = var.rds_subnetgroup_name
  description = "Subnet group for RDS database"
  subnet_ids   = [aws_subnet.subnet3.id, aws_subnet.subnet4.id]
}


resource "aws_db_instance" "postgresql" {
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_groups.name
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  username               = var.username
  password               = var.password
  port                   = var.db_port
  storage_type           = var.storage_type
  network_type           = var.network_type
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  apply_immediately      = true
  
  tags = {
    Name  = var.rds_name
    Environment = var.environment_name
  }
}



