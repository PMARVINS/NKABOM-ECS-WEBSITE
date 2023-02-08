# Public subnet 1

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.publicsubnet1-cidr
  availability_zone       = var.AZ-1
  map_public_ip_on_launch = var.launch-ip

  tags = {
    Name        = var.subnet1_name
    Environment = var.environment_name
  }
}

# Public subnet 2

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.publicsubnet2-cidr
  availability_zone       = var.AZ-2
  map_public_ip_on_launch = var.launch-ip

  tags = {
    Name        = var.subnet2_name
    Environment = var.environment_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = var.igw_name
    Environment = var.environment_name
  }
}

# public route table
resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id


  }

  tags = {
    Name        = var.publicroute_name
    Environment = var.environment_name
  }
}

# route table association - public
resource "aws_route_table_association" "routeassociation-public-1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "routeassociation-public-2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.public-route.id
}





# private subnets - natgateway - associatons 
# private subnet
resource "aws_subnet" "subnet3" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.privatesubnet1-cidr
  availability_zone       = var.AZ-1
  map_public_ip_on_launch = var.priv-launch-ip

  tags = {
    Name        = var.subnet3_name
    Environment = var.environment_name
  }
}

# private subnet 2
resource "aws_subnet" "subnet4" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.privatesubnet2-cidr
  availability_zone       = var.AZ-2
  map_public_ip_on_launch = var.priv-launch-ip

  tags = {
    Name        = var.subnet4_name
    Environment = var.environment_name
  }
}


# Elastic ip for NatGateway

resource "aws_eip" "eip" {
  vpc = true

  tags = {
    Name        = var.eip_name
    Environment = var.environment_name
  }
}



# NatGateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id        = aws_subnet.subnet1.id

  tags = {
    Environment = var.environment_name
  }
}

# private route table
resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id

  }

  tags = {
    Name        = var.privateroute_name
    Environment = var.environment_name
  }
}

resource "aws_route_table_association" "routeassociation-private-1" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.private-route.id
}

resource "aws_route_table_association" "routeassociation-private-2" {
  subnet_id      = aws_subnet.subnet4.id
  route_table_id = aws_route_table.private-route.id
}