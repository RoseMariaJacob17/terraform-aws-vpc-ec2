resource "aws_subnet" "public" {
  for_each = toset(var.public_subnet_cidrs)

  vpc_id                  = var.vpc_id
  cidr_block              = each.key
  availability_zone       = element(var.availability_zones, index(var.public_subnet_cidrs, each.key))
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${index(var.public_subnet_cidrs, each.key) + 1}"
  }
}

resource "aws_route_table_association" "public_assoc" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = var.public_route_table_id
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = {
    Name = "private-rt"
  }
}

resource "aws_subnet" "private" {
  for_each          = toset(var.private_subnet_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = each.key
  availability_zone = element(var.availability_zones, index(var.private_subnet_cidrs, each.key))

  tags = {
    Name = "private-subnet-${index(var.private_subnet_cidrs, each.key) + 1}"
  }
}

resource "aws_route_table_association" "private_assoc" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
