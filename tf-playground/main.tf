# ----------------------------------------
#            Main module
# ----------------------------------------

# Shared tfstate
terraform {
  backend "s3" {
    region = "eu-north-1"
    key    = "couchbase-std-deploy-tfstate"
    bucket = "a-tfstate-rch"
  }
}

# Provider config
provider "aws" {
  region = var.region_target
}

# Create key-pair for logging into ec2 instance
resource "aws_key_pair" "this" {
  key_name   = "rch-cb-nodes-key"
  public_key = file(var.ssh_public_key_path)
  tags = {
    Name        = join("-",["key-pair", var.resource_tags["project"],var.resource_tags["environment"]])
    Project     = var.resource_tags["project"]
    Owner       = var.resource_tags["owner"]
    Environment = var.resource_tags["environment"]
  }
} 

# Call network module
module "network" {
  source                  = "./modules/network"
  resource_tags           = var.resource_tags
  vpc_cidr_block          = "10.0.0.0/28"
  public_subnet_cidr_block = "10.0.0.0/28"
}

# Call compute module
module "node01" {
  source                 = "./modules/compute"
  depends_on             = [module.network]
  resource_tags          = var.resource_tags
  base_name              = "node01"
  instance_ami_path      = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
  instance_type          = "t3.medium"
  user_data_script_path  = "scripts/cluster-init.sh"
  user_data_args         = merge(var.couchbase_configuration, {services="data"})
  ssh_public_key_name    = aws_key_pair.this.key_name
  vpc_security_group_ids = module.network.vpc_security_group_ids
  subnet_id              = module.network.subnet_id
}

# Call compute module
module "node02" {
  source                 = "./modules/compute"
  depends_on             = [module.node01]
  resource_tags          = var.resource_tags
  base_name              = "node02"
  instance_ami_path      = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
  instance_type          = "t3.medium"
  user_data_script_path  = "scripts/server-add.sh"
  user_data_args         = merge(var.couchbase_configuration, {cluster_uri=module.node01.public_dns}, {services="data"})
  ssh_public_key_name    = aws_key_pair.this.key_name
  vpc_security_group_ids = module.network.vpc_security_group_ids
  subnet_id              = module.network.subnet_id
}

# Call compute module
module "node03" {
  source                 = "./modules/compute"
  depends_on             = [module.node01]
  resource_tags          = var.resource_tags
  base_name              = "node03"
  instance_ami_path      = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
  instance_type          = "t3.medium"
  user_data_script_path  = "scripts/server-add.sh"
  user_data_args         = merge(var.couchbase_configuration, {cluster_uri=module.node01.public_dns}, {services="data"})
  ssh_public_key_name    = aws_key_pair.this.key_name
  vpc_security_group_ids = module.network.vpc_security_group_ids
  subnet_id              = module.network.subnet_id
}

# Call compute module
module "node04" {
  source                 = "./modules/compute"
  depends_on             = [module.node01]
  resource_tags          = var.resource_tags
  base_name              = "node04"
  instance_ami_path      = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
  instance_type          = "t3.medium"
  user_data_script_path  = "scripts/server-add.sh"
  user_data_args         = merge(var.couchbase_configuration, {cluster_uri=module.node01.public_dns}, {services="query,index"})
  ssh_public_key_name    = aws_key_pair.this.key_name
  vpc_security_group_ids = module.network.vpc_security_group_ids
  subnet_id              = module.network.subnet_id
}

# Call compute module
module "node05" {
  source                 = "./modules/compute"
  depends_on             = [module.node01]
  resource_tags          = var.resource_tags
  base_name              = "node05"
  instance_ami_path      = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
  instance_type          = "t3.medium"
  user_data_script_path  = "scripts/server-add.sh"
  user_data_args         = merge(var.couchbase_configuration, {cluster_uri=module.node01.public_dns}, {services="query,index"})
  ssh_public_key_name    = aws_key_pair.this.key_name
  vpc_security_group_ids = module.network.vpc_security_group_ids
  subnet_id              = module.network.subnet_id
}

# Call compute module
module "node06" {
  source                 = "./modules/compute"
  depends_on             = [module.node01]
  resource_tags          = var.resource_tags
  base_name              = "node05"
  instance_ami_path      = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
  instance_type          = "t3.medium"
  user_data_script_path  = "scripts/server-add.sh"
  user_data_args         = merge(var.couchbase_configuration, {cluster_uri=module.node01.public_dns}, {services="eventing"})
  ssh_public_key_name    = aws_key_pair.this.key_name
  vpc_security_group_ids = module.network.vpc_security_group_ids
  subnet_id              = module.network.subnet_id
}

# Call compute module
module "node07" {
  source                 = "./modules/compute"
  depends_on             = [module.node01]
  resource_tags          = var.resource_tags
  base_name              = "node05"
  instance_ami_path      = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
  instance_type          = "t3.medium"
  user_data_script_path  = "scripts/server-add.sh"
  user_data_args         = merge(var.couchbase_configuration, {cluster_uri=module.node01.public_dns}, {services="eventing"})
  ssh_public_key_name    = aws_key_pair.this.key_name
  vpc_security_group_ids = module.network.vpc_security_group_ids
  subnet_id              = module.network.subnet_id
}

# Call compute module
module "node08" {
  source                 = "./modules/compute"
  depends_on             = [module.node01]
  resource_tags          = var.resource_tags
  base_name              = "node05"
  instance_ami_path      = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
  instance_type          = "t3.medium"
  user_data_script_path  = "scripts/server-add.sh"
  user_data_args         = merge(var.couchbase_configuration, {cluster_uri=module.node01.public_dns}, {services="backup"})
  ssh_public_key_name    = aws_key_pair.this.key_name
  vpc_security_group_ids = module.network.vpc_security_group_ids
  subnet_id              = module.network.subnet_id
}