resource "aws_route_table" "soso_second_rt" {
 vpc_id = aws_vpc.soso_vpc.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.soso_igw.id
 }
 
 tags = {
   Name = "2nd Route Table"
 }
}

# Associating Public Subnets to the Second Route Table
resource "aws_route_table_association" "public_subnet_asso" {
 count = length(var.public_subnet_cidrs)
 subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
 route_table_id = aws_route_table.soso_second_rt.id
}