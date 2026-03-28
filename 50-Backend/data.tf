data "aws_ssm_parameter" "private_subnet_id" {

    name  = "${var.project}-${var.env}-private_subnet"
}

data "aws_ssm_parameter" "catalogue_sg_id" {
     name  = "${var.project}-${var.env}-catalogue"
}




