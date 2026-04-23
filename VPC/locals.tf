locals {

    common_tags = {

        project = var.project
        environment = var.env
        terraform = true
    }
  
}