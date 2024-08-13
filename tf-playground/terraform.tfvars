# ----------------------------------------
#    Default main config - Staging env
# ----------------------------------------

region_target = "eu-west-3"

resource_tags = {
  project     = "terracluster"
  environment = "staging-rch"
  owner       = "raphael.chir@couchbase.com"
  user        = "raphael.chir@couchbase.com"
}

ssh_public_key_path = ".ssh/id_rsa.pub"
ssh_private_key_path = ".ssh/id_rsa"

couchbase_configuration = {
  cluster_name    = "terracluster-playground"
  cluster_username  = "admin"
  cluster_password  = "111111"
}