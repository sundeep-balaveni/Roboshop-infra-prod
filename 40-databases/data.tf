data "aws_ssm_parameter" "mongo_sg_id" {
     name  = "${var.project}-${var.env}-mongo_db"
}

data "aws_ssm_parameter" "redis_sg_id" {
     name  = "${var.project}-${var.env}-redis"
}

data "aws_ssm_parameter" "mysql_sg_id" {
     name  = "${var.project}-${var.env}-mysql"
}

data "aws_ssm_parameter" "database_subnet_ids" {
  name = "${var.project}-${var.env}-database_subnet"
}


