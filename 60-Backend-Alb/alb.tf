resource "aws_lb" "main" {
  name               = "roboshop-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.backend_alb_sg_id.value]
  subnets = split(",", data.aws_ssm_parameter.backend_alb_subnet_id.value)

  enable_deletion_protection = false
}


resource "aws_lb_target_group" "Catalogue-target-group" {
  name     = "Catalogue-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_ssm_parameter.vpc_id.value

}



resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Catalogue-target-group.arn
  }
 }


 resource "aws_lb_target_group_attachment" "Catalogue-target-group-attachment" {
  target_group_arn = aws_lb_target_group.Catalogue-target-group.arn
  target_id        = data.aws_ssm_parameter.catalogue_vpc_id.value
  port             = 8080
}


resource "aws_route53_record" "backend_alb" {
  zone_id = "Z0521440VTYXZ3IR185D"
  name    = "*.backend-alb-${var.env}"
  type    = "A"


  alias {
    name = aws_lb.main.dns_name
    zone_id = aws_lb.main.zone_id
    evaluate_target_health = true
  }
 
}