#!/bin/bash

HOME=/root
WORKDIR="/tmp"
SERVERVERSION="18.04"
PUPPETFILE="puppet-enterprise-2019.8.5-ubuntu-$SERVERVERSION-amd64"
PUPPETURL="https://pm.puppet.com/cgi-bin/download.cgi?dist=ubuntu&rel=$SERVERVERSION&arch=amd64&ver=latest"

echo "PUPPETFILE: $PUPPETFILE"
echo "PUPPETURL: $PUPPETURL"

cat > /tmp/pe.conf << FILE
"console_admin_password": "kieran"
"puppet_enterprise::puppet_master_host": "%%{::trusted.certname}"

# Configure for low memory use on local machines
"puppet_enterprise::profile::master::java_args": {"Xmx": "256m", "Xms": "256m"}
"puppet_enterprise::profile::puppetdb::java_args": {"Xmx": "256m", "Xms": "256m"}
"puppet_enterprise::profile::console::java_args": {"Xmx": "256m", "Xms": "256m"}
"puppet_enterprise::profile::orchestrator::java_args": {"Xmx": "256m", "Xms": "256m"}
FILE

mkdir -p /etc/puppetlabs/puppet/

curl -JLO $PUPPETURL
tar -xvzf $PUPPETFILE.tar.gz -C $WORKDIR
/tmp/$PUPPETFILE/puppet-enterprise-installer -c /tmp/pe.conf

puppet agent -t
puppet agent -t

systemctl restart pe-puppetserver.service
systemctl restart pe-puppetdb.service
systemctl restart pe-nginx.service