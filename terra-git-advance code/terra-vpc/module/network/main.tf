resource "aws_vpc" "main" {
  cidr_block       = var.mycidr
  instance_tenancy = "default"
tags = {
    Name = "main"
  }
}

  resource "aws_subnet" "pubsubnet_cidr" {
    //count = 2
     for_each = var.pubsubnet_cidr                   // "pubsubnet_cidr" < variable on which loop will work
    vpc_id     = aws_vpc.main.id                     // vpc id remain constant because our vpc is one in this case
    //cidr_block = var.pubsubnet_cidr[count.index]
      cidr_block = each.value["cidr"]                //cidr_block is predefined variable from terraform registry
                                                     // each.value is work on key
  tags = {
    Name = "Main"
  }
}

resource "aws_subnet" "prisubnet_cidr" {
    //count = 2
     for_each = var.prisubnet_cidr
    vpc_id     = aws_vpc.main.id                               // private subnet with mapping
    //cidr_block = var.pubsubnet_cidr[count.index]
      cidr_block = each.value["cidr"]

  tags = {
    Name = "Main"
  }
}
# resource "aws_subnet" "prisubnet_cidr" {
#   count = 2
#   vpc_id     = aws_vpc.main.id
#   cidr_block = var.prisubnet_cidr[count.index]    // with count 

#   tags = {
#     Name = "Main"
#   }
# }

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  
   tags = {
     Name = "my-igw"
   }
}

resource "aws_eip" "lb" {
  //count = 2
  //count = var.nat_reqd ? 1 : 0
  domain   = "vpc"
}

resource "aws_nat_gateway" "my-nat" {
  allocation_id = aws_eip.lb.id
  subnet_id      = lookup (aws_subnet.pubsubnet_cidr, "sub-1", null).id
  // we are associating nat gateway with public subnet from Map type variable .
  // so we fetch only one subnet details by lookup function .
  tags = {
    Name = "gw NAT"
  }
}

resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  
  tags = {
       Name = "myroute-table"
  }
}

resource "aws_route_table" "my-privrt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my-nat.id
  }
  tags = {
       Name = "myprivroute-table"
  }
}
resource "aws_route_table_association" "a" {
    //count = 2
    for_each = aws_subnet.pubsubnet_cidr        // route table association , for each loop work on direct subnet
  subnet_id      = each.value.id                // not on variable because subnets already created by above block
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_route_table_association" "b" {
    //count = 2
  //subnet_id      = aws_subnet.prisubnet_cidr[count.index].id
  
  for_each = aws_subnet.prisubnet_cidr
  subnet_id      = each.value.id
  route_table_id = aws_route_table.my-privrt.id
}

#    resource "aws_nat_gateway" "my_nat" {
#     count = 2
#     allocation_id = aws_eip.lb[count.index].id
#   //**********connectivity_type = "private"
#   //***********subnet_id         = aws_subnet.example.id
#     subnet_id         = aws_subnet.prisubnet_cidr[count.index].id
#   tags = {
#        Name = "mynat-gw"
#   }
# }   

