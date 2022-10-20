#!/bin/bash

if [ ! -f /opt/puppetlabs/puppet/cache/state/agent_catalog_run.lock ]; then
  exit 0
else
  puppet_lock=$(ls --full-time --time-style="+%Y-%m-%d:%H:%M:%S" /opt/puppetlabs/puppet/cache/state/agent_catalog_run.lock | sed "s/ \/opt.*//"  | sed "s/.* //")
  echo puppet_lock=$puppet_lock
fi
