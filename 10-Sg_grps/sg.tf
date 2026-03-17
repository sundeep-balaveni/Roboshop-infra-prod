module "sg" {

    count = length(var.sg_names)
    
    source = "../../Terraform-sg-module"
    env = var.env
    project = "roboshop"
    sg_name = var.sg_names[count.index]
//    vpc_id = aws_ssm_parameter.vpc_id.value  Terraform cannot read existing AWS resources unless you declare them as a data source.
     vpc_id = data.aws_ssm_parameter.vpc_id.value
  
}