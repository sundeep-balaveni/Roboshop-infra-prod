variable "ami_id"{
    type = string
    default = "ami-0b6c6ebed2801a5cb"
    description = "Ubuntu image"

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

    type = string

    default = "Mongo-db"
  


  
}

variable "project" {
    type = string
    default = "roboshop"
  
}

variable "env" {

    type = string
    default = "prod" 
}