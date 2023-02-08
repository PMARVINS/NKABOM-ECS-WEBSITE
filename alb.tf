# alb.tf

resource "aws_alb" "alb" {
  name               = "ALB-ECS-PROJECT"
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  security_groups    = [aws_security_group.lb.id]
  internal           = false
  load_balancer_type = "application" 

  tags = {
    Environment = var.environment_name
  } 
}

resource "aws_alb_target_group" "frontend" {
  name        = "frontend-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Environment = var.environment_name
  }
}

resource "aws_alb_listener" "frontend" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
  #enable above 2 if you are using HTTPS listner and change protocal from HTTPS to HTTPS


  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.frontend.arn
  }

  tags = {
    Environment = var.environment_name
  }
}





