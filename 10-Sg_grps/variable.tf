variable "project" {
    type = string
    default = "roboshop"
  
}

variable "env" {

    type = string
    default = "prod" 
}

variable "sg_names" {
    type = list(string)
    default = ["mongo_db","redis","mysql","bastion_host","Backend_alb" ,"Frontend_alb" ,"catalogue"]  
}

