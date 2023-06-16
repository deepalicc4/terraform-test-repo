output "vpc-id" {                                               // output without any loop
  value = aws_vpc.main
}
output "myvpc_cidr"{

  value = aws_vpc.main.cidr_block
}

output "sub1-id"{
value = lookup (aws_subnet.pubsubnet_cidr, "sub-1", null).id

}
output "pubsub-id" {
  value = {for k,v in aws_subnet.pubsubnet_cidr:k=>v}            // variable out with for each loop
}


output "privatesub-id" {
  value = {for k,v in aws_subnet.prisubnet_cidr:k=>v}           // variable output with for each loop
} 




# output "private-sub-id" {

#     value = aws_subnet.prisubnet_cidr[count.index].id
# }