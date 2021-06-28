# Provide VPC resource
resource "aws_vpc" "main" {
  cidr_block = var.cidr
}

# We need a gateway to connect to internet
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# Create private subnets
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  count = length(var.private_subnets)
}

# Create public subnets
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  count                   = length(var.public_subnets)
  # Specify true to indicate that instances launched into the subnet should be assigned a public IP address.
  map_public_ip_on_launch = true
}

