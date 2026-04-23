terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}



# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-ytgkuygyuyyy"
    key    = "sg_rules"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
    
  }
}
