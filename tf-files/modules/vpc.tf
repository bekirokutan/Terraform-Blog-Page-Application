
locals {
  mytag               = "Terraform_Blog_Application"
  secgr-dynamic-ports = [80, 443]
  user                = "terraform_blog"
  vpc_id              = aws_vpc.capstone-vpc-tf.id
}

resource "aws_vpc" "capstone-vpc-tf" {
  cidr_block                       = "10.90.0.0/16"
  assign_generated_ipv6_cidr_block = false
  instance_tenancy                 = "default"
  tags = {
    "Name" = "${local.mytag}-vpc"
  }
}

resource "aws_subnet" "tf-public-1a" {
  vpc_id                  = aws_vpc.capstone-vpc-tf.id
  cidr_block              = "10.90.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.mytag}-public-1a"
  }
}
resource "aws_subnet" "tf-private-1a" {
  vpc_id            = aws_vpc.capstone-vpc-tf.id
  cidr_block        = "10.90.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "${local.mytag}-tf-private-1a"
  }
}
resource "aws_subnet" "tf-public-1b" {
  vpc_id                  = aws_vpc.capstone-vpc-tf.id
  cidr_block              = "10.90.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.mytag}-tf-public-1b"
  }
}
resource "aws_subnet" "tf-private-1b" {
  vpc_id            = aws_vpc.capstone-vpc-tf.id
  cidr_block        = "10.90.5.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "${local.mytag}-tf-private-1b"
  }
}
resource "aws_internet_gateway" "capstone-igw" {
  vpc_id = aws_vpc.capstone-vpc-tf.id

  tags = {
    Name = "${local.mytag}-tf-igw"
  }
}

resource "aws_instance" "nat-instance" {
  ami                         = "ami-0356fe6f21ab7c13e"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.tf-public-1b.id
  key_name                    = var.keyname
  associate_public_ip_address = true
  source_dest_check           = false
  vpc_security_group_ids      = ["${aws_security_group.NAT-sec.id}"]
  tags = {
    "Name" = "tf-capstone-nat-ins"
  }

}
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.capstone-vpc-tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.capstone-igw.id
  }
  tags = {
    Name = "${local.mytag}-tf-tf-public-rt"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.capstone-vpc-tf.id
  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = aws_instance.nat-instance.id
  }
  tags = {
    Name = "${local.mytag}-tf-private-rt"
  }
}

resource "aws_route_table_association" "priv-rt-subnet-1" {
  subnet_id      = aws_subnet.tf-private-1a.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "priv-rt-subnet-2" {
  subnet_id      = aws_subnet.tf-private-1b.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "public-rt-subnet-1" {
  subnet_id      = aws_subnet.tf-public-1a.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public-rt-subnet-2" {
  subnet_id      = aws_subnet.tf-public-1b.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_vpc_endpoint" "s3bucket-endpoint" {
  vpc_id       = aws_vpc.capstone-vpc-tf.id
  service_name = "com.amazonaws.us-east-1.s3"
  tags = {
    "Name" = "tf-capstone-endpoint"
  }
}

resource "aws_vpc_endpoint_route_table_association" "end-point-rt" {
  route_table_id  = aws_route_table.private-rt.id
  vpc_endpoint_id = aws_vpc_endpoint.s3bucket-endpoint.id
}

resource "aws_db_subnet_group" "rdssubnet" {
  name        = "dbcaps"
  description = "aws capstone RDS Subnet Group"
  subnet_ids  = ["${aws_subnet.tf-private-1a.id}", "${aws_subnet.tf-private-1b.id}"]

  tags = {
    Name = "${local.user}_RDS_Subnet_Group"
  }
}


