#!/bin/bash
HOME=/root
WORKDIR="/tmp"
SERVERVERSION=${server_version}
PUPPETFILE="puppet-enterprise-2019.8.5-ubuntu-$SERVERVERSION-amd64"
PUPPETURL="https://pm.puppet.com/cgi-bin/download.cgi?dist=ubuntu&rel=$SERVERVERSION&arch=amd64&ver=latest"
GITURL=${git_url}
GITPRIVKEY=${git_pri_key}
GITPUBKEY=${git_pub_key}
EMAIL=${email}
EYAMLPRIVKEY=${eyaml_pri_key}
EYAMLPUBKEY=${eyaml_pub_key}
DEPLOYMENTUSERPASS=${deployment_user_password}

cat > /tmp/pe.conf << FILE
"console_admin_password": "kieran"
"puppet_enterprise::puppet_master_host": "%%{::trusted.certname}"
# Code Manager
"puppet_enterprise::profile::master::code_manager_auto_configure": true
"puppet_enterprise::profile::master::r10k_private_key": "/etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa"
"puppet_enterprise::profile::master::r10k_remote": "$GITURL"
# Disable update checks
"puppet_enterprise::profile::master::check_for_updates": false
# Configure for low memory
"puppet_enterprise::profile::master::java_args": {"Xmx": "256m", "Xms": "256m"}
"puppet_enterprise::profile::puppetdb::java_args": {"Xmx": "256m", "Xms": "256m"}
"puppet_enterprise::profile::console::java_args": {"Xmx": "256m", "Xms": "256m"}
"puppet_enterprise::profile::orchestrator::java_args": {"Xmx": "256m", "Xms": "256m"}
FILE

mkdir -p /etc/puppetlabs/puppet/

echo "*" > /etc/puppetlabs/puppet/autosign.conf/

cat > /etc/puppetlabs/puppet/csr_attributes.yaml << YAML
extension_requests:
    pp_role:  puppetmaster
YAML

curl -JLO $PUPPETURL

tar -xvzf $PUPPETFILE.tar.gz -C $WORKDIR

/tmp/$PUPPETFILE/puppet-enterprise-installer -c /tmp/pe.conf

echo "Starting Post Install"

mkdir -p /etc/puppetlabs/puppetserver/ssh

chown pe-puppet:pe-puppet /etc/puppetlabs/puppetserver/ssh/id-*

cat > /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa << FILE
$GITPRIVKEY
FILE

chmod 400 /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa

chown pe-puppet:pe-puppet /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa

cat > /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa.pub << FILE
$GITPUBKEY
FILE

mkdir /etc/puppetlabs/puppet/eyaml/
chmod -R 500 /etc/puppetlabs/puppet/eyaml/

cat > /etc/puppetlabs/puppet/eyaml/private_key.pkcs7.pem << FILE
$EYAMLPRIVKEY
FILE

chmod 400 /etc/puppetlabs/puppet/eyaml/private_key.pkcs7.pem

chown pe-puppet:pe-puppet /etc/puppetlabs/puppet/eyaml/private_key.pkcs7.pem

cat > /etc/puppetlabs/puppet/eyaml/public_key.pkcs7.pem << FILE
$EYAMLPUBKEY
FILE

chmod 400 /etc/puppetlabs/puppet/eyaml/public_key.pkcs7.pem

chown pe-puppet:pe-puppet /etc/puppetlabs/puppet/eyaml/public_key.pkcs7.pem

apt install ruby -y

puppetserver gem install hiera-eyaml
/opt/puppetlabs/puppet/bin/gem install hiera-eyaml

puppet module install pltraining-rbac

cat > /tmp/user.pp << FILE
rbac_user { 'deploy':
    ensure      => 'present',
    name        => 'code_manager_service_user',
    display_name => 'deployment user account',
    email        => '$EMAIL',
    password    => '$DEPLOYMENTUSERPASS',
    roles        => [ 'Code Deployers' ],
}
FILE

puppet apply /tmp/user.pp

rm /tmp/user.pp

puppet-access -t $${HOME}/.puppetlabs/token login --lifetime=2y << TEXT
code_manager_service_user
$DEPLOYMENTUSERPASS
TEXT

puppet agent -t
puppet agent -t