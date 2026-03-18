data "aws_ssm_parameter" "database_sg_id" {
     name  = "${var.project}-${var.env}-database"
}

data "aws_ssm_parameter" "database_subnet_ids" {
  name = "${var.project}-${var.env}-database-subnet"
}