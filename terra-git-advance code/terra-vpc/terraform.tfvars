//pubsubnet_cidr = ["10.0.1.0/24", "10.0.2.0/24"]              //with count variable ...
//prisubnet_cidr = ["10.0.3.0/24", "10.0.4.0/24"]               // count exmp with list type


mycidr = "10.0.0.0/16"

nat_reqd = true





# vpc-from_port = "22"
# vpc-to_port = "22"# vpc-protocol = "tcp"



pubsubnet_cidr = {

  sub-1 = { // < sub-1 is key in a map

    cidr = "10.0.1.0/24" // cidr is value in key sub-1
  }
  sub-2 = { //with mapping public subnet

    cidr = "10.0.2.0/24"
  }

}

prisubnet_cidr = {

  sub-3 = {

    cidr = "10.0.3.0/24"
  }
  sub-4 = { //with mapping private subnet

    cidr = "10.0.4.0/24"
  }

}

#  myname =  "sgforvpc"
# mydesc   = "my ssh protocol entry"

# myingress-desc = "my ingress rule for ssh"




 