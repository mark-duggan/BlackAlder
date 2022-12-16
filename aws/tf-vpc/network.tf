##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {
  state = "available"
}

##################################################################################
# RESOURCES
##################################################################################

# NETWORKING #
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = merge(local.common_tags, {Name="BlackAlder_VPC"})
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = local.common_tags

}

resource "aws_subnet" "subnet1" {
  cidr_block              = var.vpc_subnets_cidr_blocks[0]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags                    = merge(local.common_tags, {Name="BlackAlder_Subnet_1"})
}

resource "aws_subnet" "subnet2" {
  cidr_block              = var.vpc_subnets_cidr_blocks[1]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]
  tags                    = merge(local.common_tags, {Name="BlackAlder_Subnet_2"})
}

# ROUTING #
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id
  tags   = local.common_tags

  route {
    cidr_block = var.route_table
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta-subnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rtb.id
}

resource "aws_route_table_association" "rta-subnet2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rtb.id
}


