#!/bin/bash
# create on June 22, 2015
# By Shawn Chen <schen@virginia.edu>
# log the packets dropped at qdisc layer

logfile=$1

while :
do

    current_time=`date`
    delimit=" : "
    drop_count=`netstat -s | grep -E "dropped"`
    echo $current_time$delimit$drop_count >> $logfile
    sleep 5

done
