#!/bin/bash
# Couchbase Server cluster initialization setup
# Amazon Linux 2 AMI
# user_data already launched as root (no need sudo -s}

# Tools installation
yum install -y jq
# Must disable swappiness
sysctl vm.swappiness=0
echo "vm.swappiness=0">>/etc/sysctl.conf
# Please look at https://docs.couchbase.com/server/7.0/install/thp-disable.html as for how to PERMANENTLY alter this setting.
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never > /sys/kernel/mm/transparent_hugepage/defrag
# Get and install latest GA release
wget https://packages.couchbase.com/releases/7.0.3/couchbase-server-enterprise-7.0.3-amzn2.x86_64.rpm
rpm --install couchbase-server-enterprise-7.0.3-amzn2.x86_64.rpm
# Wait to complete :( a value of 5 doesn't work
sleep 10

#TODO sleep and check parameter store to see cluster node01 status
# or check status response curl -I -u username:pwd http://ec2-13-51-235-54.eu-north-1.compute.amazonaws.com:8091/pools
cluster_dns=$(ec2-metadata -p | cut -d " " -f 2)
export PATH=$PATH:/opt/couchbase/bin

timeout=360
interval=3

while ((timeout > 0)); do
  sleep $interval
  resp=$(curl -I -u ${cluster_username}:${cluster_password} http://${cluster_uri}:8091/pools 2>/dev/null | head -n 1 | cut -d$' ' -f2)
  if [ $resp -eq 200 ];
  then
    # Node attachment to cluster (-c options unused here) - Warn : it fails if rebalance
    couchbase-cli server-add  --server-add=http://$cluster_dns:8091 --server-add-username=${cluster_username} --server-add-password=${cluster_password} --group-name="Group 1" --services=${services} --cluster=http://${cluster_uri}:8091 --username=${cluster_username} --password=${cluster_password}
    break
  fi
  ((timeout -= interval))
done
:'
'