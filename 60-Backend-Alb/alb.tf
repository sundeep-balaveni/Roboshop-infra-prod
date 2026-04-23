resource "aws_lb" "main" {
  name               = "roboshop-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.backend_alb_sg_id.value]
  subnets            = split(",", data.aws_ssm_parameter.backend_alb_subnet_id.value)
  enable_deletion_protection = false
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    # ✅ FIX: removed hyphen in resource reference
    target_group_arn = aws_lb_target_group.catalogue_target_group.arn
  }
}

# ❌ OLD: "Catalogue-target-group" (invalid Terraform name)
# ✅ FIX: renamed to "catalogue_target_group"
resource "aws_lb_target_group" "catalogue_target_group" {
  name     = "Catalogue-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_ssm_parameter.vpc_id.value

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200-399"
  }
}

resource "aws_launch_template" "catalogue_launch_template" {

  name         = "catalogue-launch-template"
  image_id     = data.aws_ssm_parameter.catalogue_ami_id.value
  instance_type = "t3.micro"

  instance_initiated_shutdown_behavior = "terminate"

  # ✅ correct usage (keep this)
  vpc_security_group_ids = [data.aws_ssm_parameter.catalogue_sg_id.value]

  monitoring {
    enabled = true
  }

  # ❌ REMOVED: network_interfaces block
  # Reason: conflicts with vpc_security_group_ids in ASG usage

  # ❌ REMOVED: invalid placement block
  # placement {
  #   availability_zone = "us-east-1"  ❌ wrong + not needed in ASG
  # }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "catalogue-launch-template"
    }
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      Name = "catalogue-launch-template"
    }
  }
}

resource "aws_autoscaling_group" "cataloue_asg" {
  name               = "catalogue-asg"
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  force_delete       = false
  health_check_grace_period = 120

  launch_template {
    id      = aws_launch_template.catalogue_launch_template.id
    version = "$Latest"
  }

  vpc_zone_identifier = split(",", data.aws_ssm_parameter.catalogue_subnet_id.value)

  # ✅ FIX: updated reference name
  target_group_arns = [aws_lb_target_group.catalogue_target_group.arn]
}

resource "aws_autoscaling_policy" "catalogue" {
  autoscaling_group_name = aws_autoscaling_group.cataloue_asg.name
  name                   = "catalogue-launch-template"
  policy_type            = "TargetTrackingScaling"
  estimated_instance_warmup = 120

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70.0
  }
}

resource "aws_lb_listener_rule" "catalogue" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 10

  action {
    type             = "forward"
    # ✅ FIX: updated reference name
    target_group_arn = aws_lb_target_group.catalogue_target_group.arn
  }

  condition {
    host_header {
      values = ["catalogue.backend-alb-${var.env}.sndp.online"]
    }
  }
}

resource "aws_route53_record" "backend_alb" {
  zone_id = "Z0521440VTYXZ3IR185D"
  name    = "*.backend-alb-${var.env}"
  type    = "A"

  alias {
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
    evaluate_target_health = true
  }
}