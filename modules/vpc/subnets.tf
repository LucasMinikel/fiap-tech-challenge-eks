resource "aws_subnet" "private_subnet1" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/19"
  availability_zone = var.zone1

  tags = {
    Name = "${var.project_name}-${var.env}-${var.zone1}-private-subnet1"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${var.project_name}-${var.env}" = "owned"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.32.0/19"
  availability_zone = var.zone2

  tags = {
    Name = "${var.project_name}-${var.env}-${var.zone2}-private-subnet2"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${var.project_name}-${var.env}" = "owned"
  }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.64.0/19"
  availability_zone = var.zone1
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.env}-${var.zone1}-public-subnet1"
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/${var.project_name}-${var.env}" = "owned"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.96.0/19"
  availability_zone = var.zone2
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.env}-${var.zone2}-public-subnet2"
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/${var.project_name}-${var.env}" = "owned"
  }
}