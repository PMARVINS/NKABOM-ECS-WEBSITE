/*resource "aws_route53_record" "shemen1" {
  zone_id = data.aws_route53_zone.shemen.zone_id
  name    = "shemenmanna.com"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    #evaluate_target_health = true
 }
} */

/************************************************************************************************/
/*
resource "aws_route53_record" "example" {
  zone_id = "ZONE_ID"
  name    = "example.com"
  type    = "A"
  ttl     = "3600"
  alias {
    name                   = "example.com"
    zone_id                = "ZONE_ID"
    evaluate_target_health = true
  } 
  set_identifier = "web-server-1"
  weight         = 50
  health_check_id = "${aws_route53_health_check.example.id}"
  multivalue_answer_routing_policy {
    count = 2
  }
}

resource "aws_route53_health_check" "example" {
  fqdn = "example.com"
  port = 80
  type = "HTTP"
  resource_path = "/health"
  ip_address = "1.2.3.4"
}



resource "aws_route53_record" "example" {
  zone_id = "ZONE_ID"
  name    = "example.com"
  type    = "A"
  ttl     = "3600"
  records = ["1.2.3.4"]
}


variable "record_name" {
  default = "example.com"
}

variable "record_type" {
  default = "A"
}

variable "record_ttl" {
  default = "3600"
}

variable "record_values" {
  default = ["1.2.3.4"]
}
*/

