

resource "aws_instance" "catalogue" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_ssm_parameter.catalogue_sg_id.value]
  subnet_id = split(",", data.aws_ssm_parameter.private_subnet_id.value)[0]
  tags = { Name = var.instance_name} 
#   iam_instance_profile        = aws_iam_instance_profile.bastion_profile.name

  #EBS volume configuration
  
}


# resource "aws_iam_role" "bastion" {
#   name = "RoboshopProdBastion"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   })

#   tags = {
#     tag-key = "RoboshopProdBastion"
#   }
# }


# resource "aws_iam_role_policy_attachment" "bastion_ec2_full_access" {
#   role       = aws_iam_role.bastion.name
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
# }

# resource "aws_iam_instance_profile" "bastion_profile" {
#   name = "bastion-profile"
#   role = aws_iam_role.bastion.name
# }

resource "terraform_data" "Catalogue" {
    triggers_replace = aws_instance.catalogue.id
    depends_on = [ aws_instance.catalogue ]


    connection {
      type        = "ssh"
      user        = "ec2-user"
      password = "DevOps321"
      host        = aws_instance.catalogue.private_ip
    }


    provisioner "file" {

        source = "catalogue.sh"
        destination = "/tmp/bootstrap.sh"
    }

  provisioner "remote-exec" {               //terraform will use this provisioner to run the bootstrap script on the newly created instance

    
    inline = [ "chmod +x /tmp/bootstrap.sh" 
     ,  "sudo sh /tmp/bootstrap.sh"]  

   
  }


}

action "aws_ec2_instance_state" "Catalogue" {
  config {
    instance_id = aws_instance.catalogue.id
    state       = "stopped"
    depends_on = [aws_instance.catalogue]
  }
}

resource "aws_ami_from_instance" "Catalogue" {
  name               = var.instance_name
  source_instance_id = aws_instance.catalogue.id
  depends_on = [action.aws_ec2_instance_state.Catalogue]

  tags = {
    name = var.instance_name
  }
}








