resource "aws_internet_gateway" "soso_igw" {
 vpc_id = aws_vpc.soso_vpc.id
 
 tags = {
   Name = "Project VPC IG"
 }
}