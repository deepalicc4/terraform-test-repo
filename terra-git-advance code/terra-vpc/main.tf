provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}

module "ec2"{
  source         = "./module/ec2"
  sub1 = module.network.sub1-id
 mysecurity = [lookup(module.security-group.sg-output,"sg-1",null).id]

 
 


}
module "s3"{
  source = "./module/s3"
}

module "network" {
  source         = "./module/network"
  pubsubnet_cidr = var.pubsubnet_cidr
  prisubnet_cidr = var.prisubnet_cidr
  mycidr         = var.mycidr
  nat_reqd       = var.nat_reqd
}

module "security-group" {
  source = "./module/security-group"
  //myvpc-id= module.network.vpc-id  // calling >> under directory name module having network & calling the output file 
  //  & output variable name vpc-id.

  //myvpc_cidr=var.myvpc_cidr
  #  vpc-from_port = var.vpc-from_port

  # vpc-to_port = var.vpc-to_port
  # vpc-protocol = var.vpc-protocol
  # myname = var.myname

  # mydesc = var.myingress-desc

  # myingress-desc = var.myingress-desc
  sg_vpc = module.network.vpc-id.id //value call from output.tf file of network
  sg_details = {

    sg-1 = {                 // sg-1 is key
      name        = "my sg1"                           // this is not dynamic block
      description = "rules for ssh"
      ingress_rules = [                          // ingress rules is key here  , ingress_rules jo value hai 
        {                                        // voh khud map bni hui hai
          description = "rules for ssh"
          from_port   = 22
          to_port     = 22                            // this is dynamic block , because we declare this with dynamic keyword
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]

        },
        {
          description = "rules for web"
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }

      ]


    }


  }




}

output "myoutput" {
  value = module.network.pubsub-id
  //value = lookup (subnet1 id)

}
output "sg-output1" {
 value = module.security-group.sg-output

}

# output "vpc-id-output" {

#   value = module.network.vpc-id //module.your_module_name(like s3 ec2 vpc).your_outputname
# }


output "priavte-subnet-output" {
  value = module.network.privatesub-id

}