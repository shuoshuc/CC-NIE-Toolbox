#!/bin/bash
# create on May 18, 2015
# By Shawn Chen <schen@virginia.edu>
# add/delete random packet drop using iptables

act=$1

add() {
    iptables -A INPUT -m statistic --mode random --probability 0.05 -j DROP
}

del() {
    iptables -D INPUT -m statistic --mode random --probability 0.05 -j DROP
}

case "$act" in
    add)
        add
        ;;
    del)
        del
        ;;
    *)
        echo "invalid"
        ;;
esac

exit 0
