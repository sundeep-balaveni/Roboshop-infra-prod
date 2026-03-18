
resource "aws_security_group_rule" "mongo_db_myip" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${chomp(data.http.my_ip.response_body)}/32"]
  security_group_id = local.bastion_sg_id
}



resource "aws_security_group_rule" "mongo_db_ingress" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.mongo_db_sg_id
}

resource "aws_security_group_rule" "mongo_db_bastion" {  //accepting ssh from bastion
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.mongo_db_sg_id
}

resource "aws_security_group_rule" "redis_bastion" {  //accepting ssh from bastion
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.redis_sg_id
}