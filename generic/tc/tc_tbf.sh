#!/bin/sh
# Hierarchical tc rate limiter. It limits the traffic that matches the tc
# filter rules using TBF. For the other traffic that does not match, it is
# served by pfifo without any limit.
# Usage: sudo sh tc_separate.sh

rvlan=500mbit
rsnd=50mbit
residue=450mbit
export NIC=eth0
tc qdisc add dev $NIC root handle 1: htb default 11
tc class add dev $NIC parent 1: classid 1:1 htb rate $rvlan ceil $rvlan
tc class add dev $NIC parent 1:1 classid 1:10 htb rate $rsnd ceil $rvlan
tc class add dev $NIC parent 1:1 classid 1:11 htb rate $residue ceil $rvlan
tc filter add dev $NIC protocol ip parent 1:0 prio 1 u32 match ip dst 224.0.0.1/32 flowid 1:10
tc filter add dev $NIC protocol ip parent 1:0 prio 1 u32 match ip dst 0/0 flowid 1:11
