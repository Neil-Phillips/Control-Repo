#!/bin/bash

# Two options for this, latter is cleanest.
#ifconfig | grep "inet " | awk -F'[: ]+' '{ print $4 }'|grep -v 127.0.0.1
#hostname -I

#extrace IP Octets: awk -F'[. ]+' '{ print $1 }' or 2, 3, 4 etc

# UK: 
#     10.255
#     10.0
#     10.3
#     10.4
#     10.5
#     10.6
#     10.7
#     10.10
#     10.11

# NL: 
#     10.120
#     10.20

# FR: 
#     10.130
#     10.30

IP=`hostname -I`
ip1=`echo $IP |awk -F'[. ]+' '{ print $1 }'`
ip2=`echo $IP |awk -F'[. ]+' '{ print $2 }'`
ip3=`echo $IP |awk -F'[. ]+' '{ print $3 }'`
ip4=`echo $IP |awk -F'[. ]+' '{ print $4 }'`

#echo $ip1.$ip2
#echo $ip3.$ip4

case $ip2 in
  20|120 ) ZONE=nl
  ;;
  30|130 ) ZONE=fr
  ;;
  * ) ZONE=uk
  ;;
esac

echo country=$ZONE
