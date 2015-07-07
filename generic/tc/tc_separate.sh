#!/bin/sh
# Hierarchical tc rate limiter. It limits the traffic that matches the tc
# filter rules using TBF. For the other traffic that does not match, it is
# served by pfifo_fast without any limit.
# Usage: sudo sh tbfrate.sh add ethN 10mbit 10kb 2ms

export NIC=xxxx
tc qdisc add dev $NIC root handle 1: prio
tc qdisc add dev $NIC parent 1:1 handle 10: tbf rate 50mbit burst 6250 limit 600mb
tc qdisc add dev $NIC parent 1:2 handle 20: pfifo_fast
tc filter add dev $NIC protocol ip parent 1: prio 1 u32 match ip dst 224.0.0.1/32 flowid 1:1
tc filter add dev $NIC protocol ip parent 1: prio 1 u32 match ip dst 0/0 flowid 1:2
