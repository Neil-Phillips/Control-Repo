#!/bin/bash

if [ ! -f /etc/system_codename ]; then
  exit 0
else 
  codename=$(cat /etc/system_codename)
  builddate=$(ls -l --time-style=full-iso /etc/system_codename | cut -d " " -f6 | head -1)
  echo builddate=$builddate
  echo codename=$codename
fi
