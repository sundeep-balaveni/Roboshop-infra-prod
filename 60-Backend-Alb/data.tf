data "aws_ssm_parameter" "backend_alb_subnet_id" {

    name  = "${var.project}-${var.env}-private_subnet"
}

data "aws_ssm_parameter" "backend_alb_sg_id" {
     name  = "${var.project}-${var.env}-Backend_alb"
}


