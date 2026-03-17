data "aws_ssm_parameter" "database_sg_id" {
     name  = "${var.project}-${var.env}-database"
}