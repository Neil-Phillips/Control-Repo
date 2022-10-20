#!/bin/bash

# Export the path to include /opt/puppetlabs/bin as an ubuntu machne may have puppet
# in here or /usr/sbin depending on the version of puppet.

export PATH=$PATH:/opt/puppetlabs/bin

os=`lsb_release -c |awk '{print $2}'`
#Ubuntu: precise, trusty, xenial, bionic
#Debian: wheezy, jessie

DATE=`date "+%Y%m%d-%H%M%S"`

# Access token for puppet-legacy API
user='migrate'
token='O6Gi84I1tMEOKjiQKqGONA'

# Get the puppet version
puppetversion=`puppet --version |awk -F. '{print $1'}`

# If not puppet 6, exit
if [ $puppetversion != "6" ]; then
  echo "Not capable of moving."
  exit 0
fi

# Puppet 6 needs some settings
if [ $puppetversion == "6" ]; then
  echo "Puppet v6"
  puppetserver="puppet.support.toolstation.com"
  puppetproxy="puppet-proxy.support.toolstation.com"
  puppetlegacy='puppet-legacy.support.toolstation.com'
fi

# Install curl if its missing.
which curl
if [ $? -ne 0 ]; then
  echo "Curl missing..  Installing"
  apt-get -qq install curl
fi

# Test if servers can be reached, if not, no point in going on.
nc -w1 $puppetserver 8140
if [ $? == '1' ]; then
  echo "Can not connect to new puppet server"
  exit 1
fi

nc -w1 $puppetproxy 8140
if [ $? == '1' ]; then
  echo "Can not connect to new puppet proxy"
  exit 1
fi

# Get the cert name - this should match what has been added to puppet
hostname=`puppet config print certname`
domain=`facter domain`

# Get the location of the config file
config=`puppet config print config`

grep -q ${puppetserver} ${config}
if [ $? == '0' ]; then
  echo "Done, so skipping migration"
  exit 2
else
  if [ $puppetversion == '6' ]; then
    echo "Migrating to Skynet.."
# Mark H 24/12/2021 - this one line added to ensure that puppet doesn't get confused when the config is updated
    service puppet stop
    puppet config set server $puppetproxy --section agent
    puppet config set ca_server $puppetserver --section agent
    mv /etc/puppetlabs/puppet/ssl /etc/puppetlabs/puppet/ssl.v6.$DATE
    puppet agent -t
    if [ $domain = 'bdc.toolstation.com' ]; then
      echo "Bridgwater, setting the proxy.."
      export https_proxy=http://proxy.hq.toolstation.com:3128
      echo "Removing host from $puppetlegacy"
      curl -s -k -u $user:$token -H "Content-Type:application/json" -X DELETE https://$puppetlegacy/api/hosts/$hostname >/dev/null
    else
      nc -w1 $puppetlegacy 443
      if [ $? == '1' ]; then
        echo "Can not connect to API so no cleanup possible"
      else
        echo "Removing host from $puppetlegacy"
        curl -s -k -u $user:$token -H "Content-Type:application/json" -X DELETE https://$puppetlegacy/api/hosts/$hostname >/dev/null
      fi
    fi
  fi
fi
