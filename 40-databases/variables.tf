variable "ami_id"{
    type = string
    default = "ami-0220d79f3f480ecf5"
    description = "RHEL image"

}

variable "instance_type" {

    type = string
    default = "t3.micro"

  
}

variable "Hosted_zone_id_QA" {

    type = string
    default = "Z019184425TWL87B91K51"
  
}

variable "domain_name" {

    type = string
    default = "sndp.online"
  
}



variable "instance_name" {
    type = list(string)
    default = ["mongo-db" , "redis" , "mysql"]
}

variable "project" {
    type = string
    default = "roboshop"
  
}

variable "env" {

    type = string
    default = "prod" 
}