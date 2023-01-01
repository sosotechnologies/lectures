
# vpc.tf
resource "aws_vpc" "soso_vpc" {
 cidr_block = "10.0.0.0/16"
 
 tags = {
   Name = "SOSOTECH-VPC"
 }
}

# igw.tf
resource "aws_internet_gateway" "soso_igw" {
 vpc_id = aws_vpc.soso_vpc.id
 
 tags = {
   Name = "SOSOTECH-VPC IG"
 }
}

# route-tables.tf
resource "aws_route_table" "soso_second_rt" {
 vpc_id = aws_vpc.soso_vpc.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.soso_igw.id
 }
 
 tags = {
   Name = "SOSOTECH-VPC-Route-Table"
 }
}

# Associating Public Subnets to the Second Route Table
resource "aws_route_table_association" "public_subnet_asso" {
 count = length(var.public_subnet_cidrs)
 subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
 route_table_id = aws_route_table.soso_second_rt.id
}

# subnet.tf
# public  subnet
resource "aws_subnet" "public_subnets" {
 count      = length(var.public_subnet_cidrs)
 vpc_id     = aws_vpc.soso_vpc.id
 cidr_block = element(var.public_subnet_cidrs, count.index)
 
 tags = {
   Name = "SOSOTECH-VPCPublic-Subnet ${count.index + 1}"
 }
}
 
# private subnet 
resource "aws_subnet" "private_subnets" {
 count      = length(var.private_subnet_cidrs)
 vpc_id     = aws_vpc.soso_vpc.id
 cidr_block = element(var.private_subnet_cidrs, count.index)
 
 tags = {
   Name = "SOSOTECH-VPC-Private-Subnet ${count.index + 1}"
 }
}

# variables.tf
variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
 
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}