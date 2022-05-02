# ----------------------------------------
#        Compute module Main
# ----------------------------------------

# Choose ami
data "aws_ssm_parameter" "ami" {
  name = var.instance_ami_path
}

# Create ec2 instance
resource "aws_instance" "this" {
  ami                         = data.aws_ssm_parameter.ami.value
  instance_type               = var.instance_type
  key_name                    = var.ssh_public_key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = var.subnet_id
  user_data = templatefile(var.user_data_script_path, var.user_data_args)
  tags = {
    Name        = join("-",[var.base_name, var.resource_tags["project"],var.resource_tags["environment"]])
    Project     = var.resource_tags["project"]
    Owner       = var.resource_tags["owner"]
    Environment = var.resource_tags["environment"]
  }
}