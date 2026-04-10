data "aws_ssm_parameter" "backend_alb_subnet_id" {

    name  = "${var.project}-${var.env}-private_subnet"
}

data "aws_ssm_parameter" "backend_alb_sg_id" {
     name  = "${var.project}-${var.env}-Backend_alb"
}

data "aws_ssm_parameter" "catalogue_sg_id" {
     name  = "${var.project}-${var.env}-catalogue"
}

data "aws_ssm_parameter" "vpc_id" {
     name  = "${var.project}-${var.env}"
}

data "aws_ssm_parameter" "catalogue_subnet_id" {
    name  = "${var.project}-${var.env}-private_subnet"
}


data "aws_ssm_parameter" "catalogue_vpc_id" {
name  = "${var.project}-${var.env}-catalogue_vpc_id"
}

data "aws_ssm_parameter" "catalogue_ami_id" {
name  = "${var.project}-${var.env}-catalogue_ami_id"
}


