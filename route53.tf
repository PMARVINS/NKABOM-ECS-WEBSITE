
#Creating Hosted Zone for the Domain Name
resource "aws_route53_zone" "nkabom" {
  name         = "nkabomstudy.com"

  tags = { 
   Environment = var.environment_name
  }
}

#Creating a Record for the ALB dns to be attached to the Domain Name
resource "aws_route53_record" "nkabom" {
  zone_id = aws_route53_zone.nkabom.zone_id
  name    = "nkabomstudy.com"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }

  tags = {
    Environment = var.environment_name
  }
}