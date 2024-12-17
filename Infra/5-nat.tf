resource "aws_eip" "eip" {

 tags = {
   Name = "${local.cluster-name}-nat-eip"
 }
  
}

resource "aws_nat_gateway" "nat" {
  subnet_id = aws_subnet.public_subnet_zone1.id
  allocation_id = aws_eip.eip.id

  tags = {
    Name = "${local.cluster-name}-nat"
  }
  
}