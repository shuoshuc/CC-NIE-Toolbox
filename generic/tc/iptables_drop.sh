#!/bin/bash
# Created by: Shawn Chen <schen@virginia.edu>
# date: July 10, 2015
# Sets iptables to drop packets with a probability
# Usage: ./iptables_drop.sh add INPUT
# Usage: ./iptables_drop.sh del OUTPUT

act=$1
# direction of the traffic
dir=$2

add() {
    iptables -A $dir -m statistic --mode random --probability 0.01 -p udp --dport 5173 -j DROP
}

del() {
    iptables -D $dir -m statistic --mode random --probability 0.01 -p udp --dport 5173 -j DROP
}

case "$act" in
    add)
    echo -n "adding iptables rule"
    add
    echo "done"
    ;;

    del)
    echo -n "deleting iptables rule"
    del
    echo "done"
    ;;

    *)
    echo "Invalid arguments"
    ;;
esac

exit 0
