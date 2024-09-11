resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-${var.env}-nat"
  }
}

resource "aws_nat_gateway" "nat" {
  subnet_id = aws_subnet.public_subnet1.id
  allocation_id = aws_eip.nat.id

  tags = {
    Name = "${var.project_name}-${var.env}-nat"
  }
  
  depends_on = [aws_internet_gateway.igw]   
}