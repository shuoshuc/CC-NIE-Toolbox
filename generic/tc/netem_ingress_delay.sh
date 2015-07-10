#!/bin/bash
# Created by: Shawn Chen <schen@virginia.edu>
# date: July 10, 2015
# Uses the kernel IFB device to delay ingress traffic for a given period.
# Usage: ./netem_ingress_delay.sh 100

val=$1
ms="ms"
# gets the interface name
const="inet addr:"
bindip=`hostname -I | awk -F ' ' '{print $2}'`
iface=$(ifconfig | grep -B1 "$const$bindip" | awk '$1!="inet" && $1!="--" {print $1}')
export NIC=$iface

modprobe ifb
ip link set dev ifb0 up
tc qdisc add dev $NIC ingress
tc filter add dev $NIC parent ffff: \
protocol ip u32 match u32 0 0 flowid 1:1 action mirred egress redirect dev ifb0
tc qdisc add dev ifb0 root netem delay $val$ms
