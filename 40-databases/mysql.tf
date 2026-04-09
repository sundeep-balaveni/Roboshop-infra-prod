resource "aws_instance" "mysql" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_ssm_parameter.mysql_sg_id.value]
  subnet_id = split(",", data.aws_ssm_parameter.database_subnet_ids.value)[0]
  tags = { Name = var.instance_name[2] }
  iam_instance_profile = aws_iam_instance_profile.mysql.name

}


resource "aws_iam_role" "bastion" {
  name = "RoboshopProdBastion"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "RoboshopProdBastion"
  }
}

resource "aws_iam_policy" "policy" {
  name        = "mysql-policy"
  description = "A test policy"
  policy      = file("./mysql-policy.json")
}

resource "aws_iam_instance_profile" "mysql_profile" {
  name = "mysql-profile"
  role = aws_iam_role.mysql.name
}




resource "terraform_data" "mysql_bootstrap" {
  # triggers force re-run when instance changes
  triggers_replace = [
    aws_instance.mysql.id
  ]

   connection {
      type        = "ssh"
      user        = "ec2-user"
      password = "DevOps321"
      host        = aws_instance.mysql.private_ip
    }


    provisioner "file" {

        source = "mysql.sh"
        destination = "/tmp/bootstrap.sh"
    }

  provisioner "remote-exec" {               //terraform will use this provisioner to run the bootstrap script on the newly created instance

    
    inline = [ "chmod +x /tmp/bootstrap.sh" 
     ,  "sudo sh /tmp/bootstrap.sh"]  

   
  }

   
}