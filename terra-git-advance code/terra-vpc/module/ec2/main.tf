# resource "aws_instance" "web" {
#   ami           = "ami-0f5ee92e2d63afc18"
#   instance_type = "t2.micro"
#   key_name      = "win-server"

#   tags = {
#     Name = "webinstance"
#   }
# }


# resource "aws_instance" "tfvm" {
#   ami = "ami-0f5ee92e2d63afc18"
#   instance_type = "t2.micro"
#   //vpc_security_group_ids = [ aws_security_group.websg.id ]
#    key_name = aws_key_pair.deployer.key_name
#     tags = {
#       Name = "WEB-demo"
#     }
# }

resource "aws_instance" "webservers" { 
    //ami = lookup(var.ami,var.AWS_REGION) 
    ami = "ami-0f5ee92e2d63afc18"
    instance_type = "t2.micro" 
    security_groups = var.mysecurity 
    //subnet_id = [data.aws_subnet.GetSubnet] 
    subnet_id = var.sub1
    key_name = aws_key_pair.deployer.key_name
    associate_public_ip_address = true
    user_data = <<EOF
    #! /bin/bash
    sudo su
    sudo apt update
    sudo apt install nginx
    sudo systemctl start nginx
    
    EOF

    tags = { 
    Name = "Environment" 
    Env = "Dev" 
    } 
}








resource "aws_key_pair" "deployer" {
  key_name   = "win-server"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxfcet1AqpLiZo0mwxi6jlmvr6J1o5Vbq6COW6G+CDKw1BR5Ji2ILvDjUQPETHE7245PNkd83jiW6bouysxSUri07OAQQ6LrN4mS11AJ3QN60S4L/AzchA5V3e9+OBbnV4aeB5pDW6sD6KOizpGKsNV956OOjPJ5G7AcaM5Lq1EekURz8afkthK89tIgLX8AihIV6E1eMdKBEbXRdzOD3intZXyv+l6bjufaqWH7RKkRFh8zG/sB7wfkPx6u6YzdTtiJN87WkI1HdatAM6of1OE1VpQVet8Y+L+iGUHEEniXgRsiXFqiNPQZXsrEFZIQGEtD/2QrQ1gvnOdcfh/DvX"
}

# resource "aws_ebs_volume" "my-ebs-volume" {
#   availability_zone = "us-west-2a"
#   size              = 40

#   tags = {
#     Name = "my-ebs-volume"
#   }
# }


