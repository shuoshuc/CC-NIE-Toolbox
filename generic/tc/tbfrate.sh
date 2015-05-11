#!/bin/sh
# A tc rate limiter using tbf
# Usage: sudo sh tbfrate.sh add ethN 10mbit 10kb 2ms
#        sudo sh tbfrate.sh del ethN

act=$1

add() {
    dev=$2
    rate=$3mbit
    burst=$4kb
    latency=$5ms

    # set tc qdisc policy
    tc qdisc add dev $dev root tbf rate $rate burst $burst latency $latency
}

del() {
    dev=$2

    # delete tc qdisc policy
    tc qdisc del dev $dev root
}

case "$act" in
    add)
	echo -n "adding qdisc"
	add
	echo "done"
	;;

    del)
	echo -n "deleting qdisc"
	del
	echo "done"
	;;

    *)
	echo "Invalid arguments"
	;;
esac

exit 0
