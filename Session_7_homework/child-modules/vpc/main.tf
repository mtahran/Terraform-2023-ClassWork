resource "aws_vpc" "newVPC" {
  cidr_block = var.vpc_cidr_block
  tags = merge(
    local.common_tags,
    {
      Name = "newVPC"
    }
  )
}
# Subnets
resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.newVPC.id
  cidr_block        = var.private_cidr1_subnet
  availability_zone = var.aws_az_1
  tags = {
    Name = "private1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.newVPC.id
  cidr_block        = var.private_cidr2_subnet
  availability_zone = var.aws_az_2
  tags = {
    Name = "private2"
  }
}

resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.newVPC.id
  cidr_block        = var.public_cidr1_subnet
  availability_zone = var.aws_az_1
  tags = {
    Name = "public1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.newVPC.id
  cidr_block        = var.public_cidr2_subnet
  availability_zone = var.aws_az_2
  tags = {
    Name = "public2"
  }
}

#Internet Gateway, Route Table and Associations to Public Subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.newVPC.id
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_igw"
    }
  )
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.newVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_public_rtb"
    }
  )
}

resource "aws_route_table_association" "public_sub1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_rtb.id
}


resource "aws_route_table_association" "public_sub2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_rtb.id
}

#NAT Gateway, Elastic IP, Route Table and associations to Private Subnets
resource "aws_eip" "elastic_ip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw]
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_eip"
    }
  )
}

resource "aws_nat_gateway" "nat_gw" {
  depends_on    = [aws_internet_gateway.igw]
  connectivity_type = "private"
  subnet_id     = aws_subnet.public1.id
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_nat_gw"
    }
  )
}

resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.newVPC.id

  route {
    cidr_block     = var.vpc_cidr_block
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_private_rtb"
    }
  )
}

resource "aws_route_table_association" "priv_sub1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private_rtb.id
}

resource "aws_route_table_association" "priv_sub2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private_rtb.id
}

