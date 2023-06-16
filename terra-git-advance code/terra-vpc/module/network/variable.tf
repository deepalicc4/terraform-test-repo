# variable "pubsubnet_cidr"{
# }

variable "prisubnet_cidr"{
    type = map
}
variable "mycidr" {

}

variable "nat_reqd" {}
/////////////////////////////

variable "pubsubnet_cidr" {
 
}

////////////////////////////
# variable "prefix" {
#    type = map
#    default = {
#       sub-1 = {
#          az = "use2-az1"
#          cidr = "10.0.198.0/24"
#       }
#       sub-2 = {
         
#          cidr = "10.0.199.0/24"
#       }
#       sub-3 = {
        
#          cidr = "10.0.200.0/24"
#       }
#    }
# }