#!/bin/bash
# Couchbase Server cluster initialization setup
# Amazon Linux 2 AMI
# user_data already launched as root (no need sudo -s)

# Must disable swappiness
sysctl vm.swappiness=0
echo "vm.swappiness=0">>/etc/sysctl.conf
# Please look at https://docs.couchbase.com/server/7.0/install/thp-disable.html as for how to PERMANENTLY alter this setting.
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never > /sys/kernel/mm/transparent_hugepage/defrag
# Get and install latest GA release
wget https://packages.couchbase.com/releases/7.0.3/couchbase-server-enterprise-7.0.3-amzn2.x86_64.rpm
rpm --install couchbase-server-enterprise-7.0.3-amzn2.x86_64.rpm
# Wait to complete
sleep 10

export PATH=$PATH:/opt/couchbase/bin
cluster_dns=$(ec2-metadata -p | cut -d " " -f 2)

# Node and cluster initialization
couchbase-cli cluster-init  --cluster http://$cluster_dns:8091 --cluster-name ${cluster_name} --cluster-username ${cluster_username} --cluster-password ${cluster_password} --services ${services}