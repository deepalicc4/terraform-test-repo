# variable vpc-from_port{

# }
variable sg_vpc{

    
}

# variable vpc-to_port {

# }
# variable vpc-protocol{

# }
# variable myname {}
# variable mydesc{}
# variable myvpc-id{}
# variable myingress-desc{}
//variable myvpc_cidr{}


variable sg_details {

type = map(object({
name = string                       // ek loop chlta hai h variable pr or ek chlte h map k indr key h jo us pr
description = string


ingress_rules = list(object({       //value khud map bni hui hai toh isko 
                                    //  hum isko traversing k time pr ise likhte hai 
description = string
from_port = number
to_port = number
protocol = string
cidr_blocks = list(string)


}))



}))

}