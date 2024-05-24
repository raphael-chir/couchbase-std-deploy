# ----------------------------------------
#    Default main config - Staging env
# ----------------------------------------

region_target = "eu-north-1"

resource_tags = {
  project     = "terracluster"
  environment = "staging-rch"
  owner       = "raphael.chir@couchbase.com"
}

ssh_public_key_path = ".ssh/id_rsa.pub"
ssh_private_key_path = ".ssh/id_rsa"

couchbase_configuration = {
  cluster_name    = "terracluster-playgound"
  cluster_username  = "admin"
  cluster_password  = "111111"
}