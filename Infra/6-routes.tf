resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = aws_vpc.vpc.cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    # Must mention nat gw, you will face issue in state matching process
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${local.cluster-name}-private-route"
  }
}


resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = aws_vpc.vpc.cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${local.cluster-name}-public-route"
  }
}

resource "aws_route_table_association" "private_subnet_1" {
  subnet_id      = aws_subnet.private_subnet_zone1.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_subnet_2" {
  subnet_id      = aws_subnet.private_subnet_zone2.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "public_subnet_1" {
  subnet_id      = aws_subnet.public_subnet_zone1.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public_subnet_2" {
  subnet_id      = aws_subnet.public_subnet_zone2.id
  route_table_id = aws_route_table.public_route.id
}