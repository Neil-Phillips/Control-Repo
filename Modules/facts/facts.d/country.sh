#!/bin/bash

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
#ip1=`echo $IP |awk -F'[. ]+' '{ print $1 }'`
ip2=`echo $IP |awk -F'[. ]+' '{ print $2 }'`
#ip3=`echo $IP |awk -F'[. ]+' '{ print $3 }'`
#ip4=`echo $IP |awk -F'[. ]+' '{ print $4 }'`

case $ip2 in
  20|120|140 ) ZONE=nl
  ;;
  30|130 ) ZONE=fr
  ;;
  * ) ZONE=uk
  ;;
esac

echo country=$ZONE
