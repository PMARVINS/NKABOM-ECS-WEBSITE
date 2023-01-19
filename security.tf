# security.tf
# ALB Security Group: Edit to restrict access to the application

resource "aws_security_group" "lb" {
  name        = "myapp-load-balancer-security-group"
  description = "controls access to the ALB"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = var.frontend_port
    to_port     = var.frontend_port
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    protocol    = "tcp"
    from_port   = var.backend_port
    to_port     = var.backend_port
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Traffic to the ECS cluster should only come from the ALB

resource "aws_security_group" "ecs_tasks" {
  name        = "myapp-ecs-tasks-security-group"
  description = "allow inbound access from the ALB only"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    protocol        = "tcp"
    from_port       = var.frontend_port
    to_port         = var.frontend_port
    security_groups = [aws_security_group.lb.id] #traffic from Loadbalancer only
  }
  
  ingress {
    protocol        = "tcp"
    from_port       = var.backend_port
    to_port         = var.backend_port
    security_groups = [aws_security_group.lb.id]
  }


  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#security group for the RDS

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow traffic from ecs-fargate containers to database"
  vpc_id      = aws_vpc.vpc.id


  ingress {
    protocol        = "tcp"
    from_port       = 5432
    to_port         = 5432
    security_groups = [aws_security_group.ecs_tasks.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
