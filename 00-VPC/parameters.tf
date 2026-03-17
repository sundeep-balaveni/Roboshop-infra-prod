resource "aws_ssm_parameter" "vpc_id" {
  name  = "${var.project}-${var.env}"
  type  = "String"
  value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids" {

  name  = "${var.project}-${var.env}-public_subnet"
  type =  "StringList"
  value = join(",", module.vpc.public_subnet_id)

}

resource "aws_ssm_parameter" "private_subnet_ids" {

  name  = "${var.project}-${var.env}-private_subnet"
  type =  "StringList"
  value = join(",", module.vpc.private_subnet_id)

}

resource "aws_ssm_parameter" "database_subnet_ids" {

  name  = "${var.project}-${var.env}-database_subnet"
  type =  "StringList"
  value = join(",", module.vpc.database_subnet_id)

}