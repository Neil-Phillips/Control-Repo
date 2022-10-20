#!/bin/bash

dns_check=$(host api.toolstation.com | sed "s/.*REFUSED.*/fail/" | sed "s/.*api.toolstation.com has address.*/pass/")
echo dns_check=$dns_check
dns_server=$(nslookup all | grep "Server" | sed "s/Server.*[\t]//")
echo dns_server=$dns_server
router_addr=$(dig +time=1 +tries=1 @resolver4.opendns.com  myip.opendns.com +short | sed ':a;N;$!ba;s/\n//g' | sed "s/\"//g" | grep -v "DiG" )
if [ -z "$router_addr" ]
then
      router_addr=$(dig -t txt o-o.myaddr.l.google.com +short | grep -v subnet | sed "s/\"//g")
fi
echo router_addr=$router_addr
