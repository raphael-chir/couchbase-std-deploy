# ----------------------------------------
#    Main module Input variables
# ----------------------------------------

variable "region_target" {
  description = "The host AWS region for services usage"
  type        = string
}

variable "resource_tags" {
  description = "Baseline tags to identify resources"
  type        = map(string)
}

variable "ssh_public_key_path" {
  description = "SSH public key path"
  type        = string
}

variable "ssh_private_key_path" {
  description = "SSH private key path - WARN just for ephemeral demo usage ! No prod concern"
  type        = string
}

variable "couchbase_configuration" {
  description = "Map all configurations of a couchbase cluster"
  type = map(string)
  sensitive = true
}