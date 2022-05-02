# ----------------------------------------
#    Network module Input variables
# ----------------------------------------

# Generic tags to identify resources
variable "resource_tags" {
  description = "Baseline tags to identify resources"
  type        = map(string)
}

# VPC cidr blocks
variable "vpc_cidr_block" {
  description = "The main vpc cidr block definition"
  type = string
}

# Public subnet cidr block
variable "public_subnet_cidr_block" {
  description = "Public subnet cidr block definition"
  type = string
}

# Cluster Security Groups - Ingress rules 
variable "ingress-rules" {
  type = list(object({
    port        = number
    proto       = string
    cidr_blocks = list(string) 
  }))
  default = [
    {
      port    = -1
      proto   = "all"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}