output "vpc_id" {

    value = module.vpc.vpc_id  //this came from the output.tf of VPC module. We are exporting it here to make it available for other modules. 
}





