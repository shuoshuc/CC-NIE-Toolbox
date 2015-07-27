#!/bin/sh
# Created by: Shawn <schen@virginia.edu>
# Date: July 23, 2015
# Hierarchical tc rate limiter. It limits the traffic using HTB. A tc filter
# is applied to separate multicast and other traffic. For the multicast traffic,
# it is limited to rsnd but can borrow from the rest bandwidth. For the other
# traffic that does not fall into rsnd, it is limited to be rvlan - rsnd.
#
# Usage: sudo sh tc_htb.sh

rvlan=100mbit
rsnd=50mbit
residue=50mbit

const="inet addr:"
bindip=`hostname -I | awk -F ' ' '{print $2}'`
iface=$(ifconfig | grep -B1 "$const$bindip" | awk '$1!="inet" && $1!="--" {print $1}')
export NIC=$iface

tc qdisc add dev $NIC root handle 1: htb default 11
tc class add dev $NIC parent 1: classid 1:1 htb rate $rvlan ceil $rvlan
tc class add dev $NIC parent 1:1 classid 1:10 htb rate $rsnd ceil $rvlan
tc class add dev $NIC parent 1:1 classid 1:11 htb rate $residue ceil $rvlan
tc filter add dev $NIC protocol ip parent 1:0 prio 1 u32 match ip dst 224.0.0.1/32 flowid 1:10
tc filter add dev $NIC protocol ip parent 1:0 prio 1 u32 match ip dst 0/0 flowid 1:11
