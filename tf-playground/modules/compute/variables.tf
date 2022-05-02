# ----------------------------------------
#    Compute module Input variables
# ----------------------------------------

variable "resource_tags" {
  description = "Baseline tags to identify resources"
  type        = map(string)
}

variable "base_name" {
  description = "Instance base name"
  type        = string
}

variable "instance_ami_path" {
  description = "Instance AMI ssm parameters path"
  type        = string
}

variable "ssh_public_key_name" {
  description = "SSH public key resource name"
  type        = string
}

variable "instance_type" {
  description = "Instance compute type"
  type        = string
}

variable "user_data_script_path" {
  description = "user data script path"
  type        = string
}

variable "user_data_args" {
  description = "Map of args K/V used in user_data"
  type        = map(any)
}

variable "vpc_security_group_ids" {
  description = "List of SG ids"
  type        = list(string)
}

variable "subnet_id" {
  description = "The subnet id where instance will be deployed"
  type        = string
}