locals {
  mongo_db_sg_id  = data.aws_ssm_parameter.mongo_db_sg_id.value
  mysql_sg_ig = data.aws_ssm_parameter.mysql_sg_id.value
  redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
  bastion_sg_id =  data.aws_ssm_parameter.bastion_sg_id.value
  backend_alb_sg_id = data.aws_ssm_parameter.backend_alb_sg_id.value
  catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
}