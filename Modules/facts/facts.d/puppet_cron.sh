#!/bin/bash

if [ ! -f /var/build/puppet-cron ]; then
  exit 0
else 
  puppet_cron=$(cat /var/build/puppet-cron)
  echo puppet_cron=$puppet_cron
fi
