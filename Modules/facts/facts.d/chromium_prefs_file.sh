#!/bin/bash

if [ ! -f /etc/chromium-browser/policies/managed/default-policy.json ]; then
  exit 0
else 
  echo chromium_sysprefs="true"
fi
