resource "aws_ssm_parameter" "catalogue_id" {
  name  = "${var.project}-${var.env}-catalogue_vpc_id"
  type  = "String"
  value = aws_instance.catalogue.id
}


resource "aws_ssm_parameter" "Catalouge_ami_id" {
  name  = "${var.project}-${var.env}-catalogue_ami_id"
  type  = "String"
  value = aws_ami_from_instance.Catalogue.id
}