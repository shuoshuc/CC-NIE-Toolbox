#!/bin/bash

LOG=$(printenv LDMHOME)/cpu_measure.log
while true
do
    pidstat -C ldm >> $LOG
    echo -en "\n\n" >> $LOG
    sleep 60
done
