variable "project" {
    type = string
    default = "roboshop"
  
}

variable "env" {

    type = string
    default = "test" 
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "access_level_public" {
    type = string
    default = "public"
  
}

variable "access_level_private" {
    type = string
    default = "private"
  
}

variable "public_subnet_cidr" {

  type = list(string)

  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "database_subnet_cidr" {

  type = list(string)

  default = [
    "10.0.5.0/24",
    "10.0.6.0/24"
  ]
}



variable "private_subnet_cidr" {

  type = list(string)

  default = [
    "10.0.3.0/24",
    "10.0.4.0/24"
  ]
}

variable "available_zones" {

  type = list(string)

  default = [
    "us-east-1a",
    "us-east-1b"
  ]

}

variable "is_peering_enabled" {
  type = bool
  default = false
}
