#!/bin/bash

#sed "s/TSUKRP0028-Rastelly..toolstation.shop/TSUKRP0028-Rastelly.toolstation.shop/" /etc/hosts > /tmp/hosts
#DIFF=$(diff /etc/hosts /tmp/hosts) 
#if [ "$DIFF" != "" ] 
#then
#  cp /tmp/hosts /etc/hosts
 
#echo "127.0.0.1       localhost" > /etc/hosts
#echo "127.0.1.1       TSUKRP0028-Rastelly.pi.toolstation.shop TSUKRP0028-Rastelly" >> /etc/hosts
#echo "# Added during the puppet install " >> /etc/hosts
#echo "::1             localhost ip6-localhost ip6-loopback" >> /etc/hosts
#echo "ff02::1         ip6-allnodes" >> /etc/hosts
#echo "ff02::2         ip6-allrouters" >> /etc/hosts
#chown root: /etc/hosts
#chmod 644 /etc/hosts

apt-get --fix-missing update  > /tmp/puppet_run.log 2>&1
dpkg --configure -a >> /tmp/puppet_run.log 2>&1
apt-get install -f >> /tmp/puppet_run.log 2>&1

rm /etc/cron.hourly/fix_pi_name
#fi

exit 0
