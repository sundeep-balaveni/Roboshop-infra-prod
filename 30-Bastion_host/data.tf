data "aws_ssm_parameter" "bastion_sg_id" {
     name  = "${var.project}-${var.env}-bastion_host"
}

data "aws_ssm_parameter" "public_subnet_id" {

    name  = "${var.project}-${var.env}-public_subnet"
}