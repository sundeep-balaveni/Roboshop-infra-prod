resource "aws_iam_role" "mysql" {
  name = "Roboshop-MySQL-Role"

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
    tag-key = "Roboshop-MySQL-Role"
  }
}

resource "aws_iam_policy" "mysql" {

    name = "RoboshopMySQLPolicy"
    description = "policy for MySQL EC2 instance"
    policy = file("mysql-policy.json")
}

resource "aws_iam_role_policy_attachment" "mysql-attachment" { 
  role       = aws_iam_role.mysql.name
  policy_arn = aws_iam_policy.mysql.arn
}

resource "aws_iam_instance_profile" "mysql" {
  name = "Roboshop-MySQL-Instance-Profile"
  role = aws_iam_role.mysql.name

}