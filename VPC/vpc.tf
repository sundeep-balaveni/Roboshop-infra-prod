resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project}-${var.env}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project}-${var.env}"
  }
}


resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = var.available_zones[count.index]
  
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.project}-${var.env}-${var.access_level_public}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = var.available_zones[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.project}-${var.env}-${var.access_level_private}"
  }
}

resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidr[count.index]
  availability_zone = var.available_zones[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.project}-${var.env}-${var.access_level_private}-db"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project}-${var.env}-${var.access_level_public}"
  } 
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project}-${var.env}-${var.access_level_private}"
  } 
}

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project}-${var.env}-${var.access_level_private}-db"
  } 
}
  
//creating routes to the internet 

resource "aws_route" "public" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
  
}

resource "aws_eip" "one" {
  domain   = "vpc"
  tags = {
    Name = "${var.project}-${var.env}-${var.access_level_private}-elstic_ip"
  }
}

resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.one.id
  subnet_id     = aws_subnet.public[0].id   //becuase it is public subnet it has automatic routes to the internet gateway, so we can place the NAT

  tags = {
    Name = "gw NAT"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}

resource "aws_route" "private" {
  route_table_id = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.NAT.id 
}

resource "aws_route" "databse" {
  route_table_id = aws_route_table.database.id
  destination_cidr_block = "0.0.0.0/0"   
//destination_cidr_block tells the route table:
//If traffic is going to this destination, send it through this target.
  nat_gateway_id = aws_nat_gateway.NAT.id 
}


resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr)
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
  
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr)
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
  
}






resource "aws_route_table_association" "database" {
  count = length(var.private_subnet_cidr)
  subnet_id = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database.id
  
}


