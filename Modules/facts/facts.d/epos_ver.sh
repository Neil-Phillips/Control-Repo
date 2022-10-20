#!/bin/bash

if [ ! -e /usr/local/bin/epos.AppImage ]; then
  exit 0
else
  epos_installed=$(ls -la /usr/local/bin/epos.AppImage | sed "s/.*epos-//" | sed "s/-.*//")
  echo epos_installed=$epos_installed
fi
