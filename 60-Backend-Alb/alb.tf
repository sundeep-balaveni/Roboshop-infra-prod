resource "aws_lb" "main" {
  name               = "roboshop-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.backend_alb_sg_id.value]
  subnets = split(",", data.aws_ssm_parameter.backend_alb_subnet_id.value)

  enable_deletion_protection = false
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

 default_action {
  type = "fixed-response"

  fixed_response {
    content_type = "text/plain"
    message_body = "Hello, this is self content from the ALB!"
    status_code  = "200"
  }
 }
}

resource "aws_route53_record" "backend_alb" {
  zone_id = "Z09029021ATNZMJUN4M6"
  name    = "*.backend-alb-${var.env}"
  type    = "A"


  alias {
    name = aws_lb.main.dns_name
    zone_id = aws_lb.main.zone_id
    evaluate_target_health = true
  }
 
}