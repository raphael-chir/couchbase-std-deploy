# ----------------------------------------
#        Network module Main
# ----------------------------------------

# VPC creation
resource "aws_vpc" "cb_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = join("-",["vpc", var.resource_tags["project"],var.resource_tags["environment"]])
    Project     = var.resource_tags["project"]
    Owner       = var.resource_tags["owner"]
    Environment = var.resource_tags["environment"]
  }
}

# Internet Gateway to attach to VPC
resource "aws_internet_gateway" "cb_vpc_internet_gw" {
  vpc_id = aws_vpc.cb_vpc.id
  tags = {
    Name        = join("-",["igw", var.resource_tags["project"],var.resource_tags["environment"]])
    Project     = var.resource_tags["project"]
    Owner       = var.resource_tags["owner"]
    Environment = var.resource_tags["environment"]
  }
}

# Get the main route table through data clause
data "aws_route_table" "main_route_table" {
  filter {
    name = "association.main"
    values = ["true"]
  }
  filter {
    name = "vpc-id"
    values = [aws_vpc.cb_vpc.id]
  }
}

# Create route table upon the main route
resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = data.aws_route_table.main_route_table.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cb_vpc_internet_gw.id
  }
  tags = {
    Name        = join("-",["route", var.resource_tags["project"],var.resource_tags["environment"]])
    Project     = var.resource_tags["project"]
    Owner       = var.resource_tags["owner"]
    Environment = var.resource_tags["environment"]
  }
}

# Get all AZ related to the region
data "aws_availability_zones" "avz" {
  state = "available"
}

# Create a public subnet
resource "aws_subnet" "cb_public_subnet" {
  vpc_id     = aws_vpc.cb_vpc.id
  cidr_block = var.public_subnet_cidr_block
  availability_zone = element(data.aws_availability_zones.avz.names, 0)
  tags = {
    Name        = join("-",["public-subnet", var.resource_tags["project"],var.resource_tags["environment"]])
    Project     = var.resource_tags["project"]
    Owner       = var.resource_tags["owner"]
    Environment = var.resource_tags["environment"]
  }
}

# Create a Security Group to be attached with public cb instance
resource "aws_security_group" "cb_sg" {
  name        = "couchbase-sg"
  description = "Allow traffic to services"
  vpc_id     = aws_vpc.cb_vpc.id
  
  dynamic "ingress" {
    for_each = var.ingress-rules
    content {
      from_port        = ingress.value["port"]
      to_port          = ingress.value["port"]
      protocol         = ingress.value["proto"]
      cidr_blocks      = ingress.value["cidr_blocks"]
    }
  }
  egress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name        = join("-",["couchbase-sg", var.resource_tags["project"],var.resource_tags["environment"]])
    Project     = var.resource_tags["project"]
    Owner       = var.resource_tags["owner"]
    Environment = var.resource_tags["environment"]
  }
}