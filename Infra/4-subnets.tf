resource "aws_subnet" "private_subnet_zone1" {
  vpc_id = aws_vpc.vpc.id
  availability_zone = local.zone1
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "${local.cluster-name}-private-subnet-${local.zone1}"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${local.cluster-name}" = "owned"
   }
}

resource "aws_subnet" "private_subnet_zone2" {
  vpc_id = aws_vpc.vpc.id
  availability_zone = local.zone2
  cidr_block = "10.0.2.0/24"
  
  tags = {
    Name = "${local.cluster-name}-private-subnet-${local.zone2}"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster${local.cluster-name}" = "owned"
  }
}

resource "aws_subnet" "public_subnet_zone1" {
  vpc_id = aws_vpc.vpc.id
  availability_zone = local.zone1
  cidr_block = "10.0.10.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.cluster-name}-public-subnet-${local.zone1}"
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/${local.cluster-name}" = "owned"
  }
}

resource "aws_subnet" "public_subnet_zone2" {
  vpc_id = aws_vpc.vpc.id
  availability_zone = local.zone2
  cidr_block = "10.0.20.0/24"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${local.cluster-name}-public-subnet-${local.zone2}"
    "kubernetes.io/role/elb" ="1"
    "kubernetes.io/cluster/${local.cluster-name}" = "owned"
  }
    
}