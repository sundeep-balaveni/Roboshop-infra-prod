resource "aws_ssm_parameter" "mysql-password" {
  name  = "Roboshop-MySQL-password"
  type  = "String"
  value = "RoboShop@1"
}