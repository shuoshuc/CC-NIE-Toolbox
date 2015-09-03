#!/bin/sh
# Created by: Shawn <schen@virginia.edu>
# Date: September 3, 2015
# Hierarchical tc rate limiter. It limits the traffic using HTB. A tc filter
# is applied to separate multicast and other traffic. For the multicast traffic,
# it is limited to rsnd and cannot borrow from the rest bandwidth. For the
# other traffic that does not fall into rsnd, it is limited to be rvlan - rsnd.

rvlan=100mbit
rsnd=40mbit
residue=60mbit

const="inet addr:"
bindip=`hostname -I | awk -F ' ' '{print $2}'`
iface=$(ifconfig | grep -B1 "$const$bindip" | awk '$1!="inet" && $1!="--" {print $1}')
export NIC=$iface

tc qdisc add dev $NIC root handle 1: htb default 2
tc class add dev $NIC parent 1: classid 1:1 htb rate $rsnd ceil $rsnd
tc qdisc add dev $NIC parent 1:1 handle 10: bfifo limit 600mb
tc class add dev $NIC parent 1: classid 1:2 htb rate $residue ceil $residue
tc qdisc add dev $NIC parent 1:2 handle 11: bfifo limit 600mb

tc filter add dev $NIC protocol ip parent 1:0 prio 1 u32 match ip dst 224.0.0.1/32 flowid 1:1
tc filter add dev $NIC protocol ip parent 1:0 prio 1 u32 match ip dst 0/0 flowid 1:2
