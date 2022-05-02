# ---------------------------------------------
#    Network Module Output return variables
# ---------------------------------------------

# Return list of security groups created on this VPC
output "vpc_security_group_ids" {
  value = [aws_security_group.cb_sg.id]
}

# Return the public subnet id
output "subnet_id" {
  value = aws_subnet.cb_public_subnet.id
}