#!/bin/bash

if [ ! -f /usr/local/bin/tosadmin/location ]; then
  exit 0
else 
  location=$(cat /usr/local/bin/tosadmin/location |tr '[:upper:]' '[:lower:]')
  echo location=$location
fi
