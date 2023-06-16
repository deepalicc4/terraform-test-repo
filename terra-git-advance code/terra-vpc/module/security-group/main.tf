
/////////// security group ///////////////
resource "aws_security_group" "allow_tls" {
  for_each = var.sg_details          // sg_details user-defined .
  name        = each.value["name"]
  description = each.value["description"]
  vpc_id      = var.sg_vpc // you can direct fetch value from main.tf under root directory

dynamic "ingress" {                             //map within the map , so usko ese retrive krte hai
    for_each = lookup(each.value, "ingress_rules", [])
    content{
    description      = lookup(ingress.value, "description", null)  //map , key ,  value
    from_port        = lookup(ingress.value, "from_port",null)
    to_port          = lookup(ingress.value, "to_port",null)
    protocol         = lookup(ingress.value, "protocol",null)
    cidr_blocks      = lookup(ingress.value, "cidr_blocks",null)
  }
  }
  tags = {
    Name = "allow_tls"
  }
}

////////////////////////

# resource "aws_security_group" "custom-sg" {
#   name        = var.myname
#   description = var.mydesc
#   //vpc_id      = aws_vpc.main.id
#    vpc_id       = var.myvpc-id
  

#   ingress {
#     description      = var.myingress-desc
#     from_port        = var.vpc-from_port
#     to_port          = var.vpc-to_port
#     protocol         = var.vpc-protocol
#     cidr_blocks      = ["0.0.0.0/0"]        
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "custom-sg"
#   }
# }
# /////////////////////////////