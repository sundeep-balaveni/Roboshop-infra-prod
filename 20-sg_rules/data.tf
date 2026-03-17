data "aws_ssm_parameter" "mongo_db_sg_id" {
    
     name  = "${var.project}-${var.env}-mongo_db"
 
}

data "aws_ssm_parameter" "redis_sg_id" {
    
     name  = "${var.project}-${var.env}-redis"
 
}

data "aws_ssm_parameter" "mysql_sg_id" {
    
     name  = "${var.project}-${var.env}-mysql"
 
}

data "aws_ssm_parameter" "bastion_sg_id" {
    
     name  = "${var.project}-${var.env}-bastion_host"
 
}

data "http" "my_ip" {
  url = "http://ipv4.icanhazip.com"
}