# Public subnet 1

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.publicsubnet1-cidr
  availability_zone       = var.AZ-1
  map_public_ip_on_launch = var.launch-ip

  tags = {
    Name = "sub-1"
  }
}

# Public subnet 2

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.publicsubnet2-cidr
  availability_zone       = var.AZ-2
  map_public_ip_on_launch = var.launch-ip

  tags = {
    Name = "sub-2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw"
  }
}

# public route table
resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id


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
    Name = "sub-3"
  }
}

# private subnet 2
resource "aws_subnet" "subnet4" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.privatesubnet2-cidr
  availability_zone       = var.AZ-2
  map_public_ip_on_launch = var.priv-launch-ip

  tags = {
    Name = "sub-4"
  }
}


# Elastic ip for NatGateway

resource "aws_eip" "eip" {
  vpc = true

  tags = {
    Name = "eip"
  }
}




# NatGateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id        = aws_subnet.subnet1.id

  tags = {
    Name = "gw-NAT"
  }
}

# private route table
resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id

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