resource "aws_subnet" "public_subnet_us_east_1a" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block              = "10.0.0.0/20"
  map_public_ip_on_launch = true
  availability_zone       = format("%sa", var.aws_region)

  tags = map(
    "Name", format("%s-public-1a", var.cluster_name),
    "kubernetes.io/cluster/${var.cluster_name}", "shared"
  )
}

resource "aws_subnet" "public_subnet_us_east_1c" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block              = "10.0.16.0/20"
  map_public_ip_on_launch = true
  availability_zone       = format("%sc", var.aws_region)

  tags = map(
    "Name", format("%s-public-1c", var.cluster_name),
    "kubernetes.io/cluster/${var.cluster_name}", "shared"
  )
}

resource "aws_route_table_association" "public_subnet_us_east_1a_association" {
  subnet_id      = aws_subnet.public_subnet_us_east_1a.id
  route_table_id = aws_route_table.igw_route_table.id
}

resource "aws_route_table_association" "public_subnet_us_east_1c_association" {
  subnet_id      = aws_subnet.public_subnet_us_east_1c.id
  route_table_id = aws_route_table.igw_route_table.id
}