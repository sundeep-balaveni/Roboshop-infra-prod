resource "aws_instance" "mysql" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_ssm_parameter.mysql_sg_id.value]
  subnet_id = split(",", data.aws_ssm_parameter.database_subnet_ids.value)[0]
  tags = { Name = var.instance_name[2] }
  iam_instance_profile = aws_iam_instance_profile.mysql.name

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