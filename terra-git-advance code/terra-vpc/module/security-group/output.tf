
output "sg-output" {
  value = {for k,v in aws_security_group.allow_tls:k=>v}           // variable output with for each loop
} 

# output "mysg"{

#   value = lookup(aws_security_group.allow_tls, "sg-1", null)
# }

