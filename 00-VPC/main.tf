module "vpc" {
  source = "../VPC"
  project = "roboshop"
  env = var.env

  
}