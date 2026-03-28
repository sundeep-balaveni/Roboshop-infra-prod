resource "aws_ssm_parameter" "catalogue_id" {
  name  = "${var.project}-${var.env}-catalogue_vpc_id"
  type  = "String"
  value = aws_instance.catalogue.id
}
