#create vpc
resource "aws_vpc" "v1" {
  cidr_block = "172.120.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "utc-app1"
    Env = "dev"
    Team = "wdp"
    Created-by = "Viviane D"
  }
}

#internet gateway
resource "aws_internet_gateway" "gtw" {
  vpc_id = aws_vpc.v1.id
}

# public subnet
resource "aws_subnet" "pub1" {
  availability_zone = "us-east-1a" 
  vpc_id = aws_vpc.v1.id
  cidr_block = "172.120.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "utc-app1-public-subnet-1"
  }
}
resource "aws_subnet" "pub2" {
  availability_zone = "us-east-1b" 
  vpc_id = aws_vpc.v1.id
  cidr_block = "172.120.2.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "utc-app1-public-subnet-2"
  }
}

#private subnet
resource "aws_subnet" "priv1" {
  availability_zone = "us-east-1a" 
  vpc_id = aws_vpc.v1.id
  cidr_block = "172.120.3.0/24"
  tags = {
    Name = "utc-app1-private-subnet-1"
  }
}
resource "aws_subnet" "priv2" {
  availability_zone = "us-east-1b" 
  vpc_id = aws_vpc.v1.id
  cidr_block = "172.120.4.0/24"
  tags = {
    Name = "utc-app1-private-subnet-2"
  }
}

#NAT gateway

resource "aws_eip" "eip1" {}

resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.eip1.id
  subnet_id = aws_subnet.pub1.id
}

#private route table

resource "aws_route_table" "rtprivate" {
  vpc_id = aws_vpc.v1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat1.id
  }
}

#public route table

resource "aws_route_table" "rtpublic" {
  vpc_id = aws_vpc.v1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gtw.id
  }
}

# public route table association

resource "aws_route_table_association" "purt1" {
  subnet_id = aws_subnet.pub1.id
  route_table_id = aws_route_table.rtpublic.id
}
resource "aws_route_table_association" "purt2" {
  subnet_id = aws_subnet.pub2.id
  route_table_id = aws_route_table.rtpublic.id
}

# priv route association
resource "aws_route_table_association" "privt1" {
  subnet_id = aws_subnet.priv1.id
  route_table_id = aws_route_table.rtprivate.id
}
resource "aws_route_table_association" "privt2" {
  subnet_id = aws_subnet.priv2.id
  route_table_id = aws_route_table.rtprivate.id
}

