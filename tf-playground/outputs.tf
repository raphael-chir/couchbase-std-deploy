# ---------------------------------------------
#    Main Module Output return variables
# ---------------------------------------------

output "node01_public_ip" {
  value = join("",["ssh -i ", var.ssh_private_key_path," ec2-user@", module.node01.public_ip])
}

output "node01_public_dns" {
  value = join("",["http://",module.node01.public_dns,":8091"])
}

output "node02_public_ip" {
  value = join("",["ssh -i ", var.ssh_private_key_path," ec2-user@", module.node02.public_ip])
}

output "node02_public_dns" {
  value = join("",["http://",module.node02.public_dns,":8091"])
}

output "node03_public_ip" {
  value = join("",["ssh -i ", var.ssh_private_key_path," ec2-user@", module.node03.public_ip])
}

output "node03_public_dns" {
  value = join("",["http://",module.node03.public_dns,":8091"])
}