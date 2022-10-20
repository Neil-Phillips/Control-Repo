#!/bin/bash

if [ ! -f /usr/lib/firefox/defaults/pref/syspref.js ]; then
  exit 0
else 
  echo firefox_sysprefs="true"
fi
