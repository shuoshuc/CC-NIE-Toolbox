#!/bin/bash

LOG=$(printenv LDMHOME)/cpu_measure.log
while true
do
    ps -eo pcpu,pid,args | grep -E 'ldmd|mldm'
    echo -en "\n\n" >> $LOG
    sleep 60
done
