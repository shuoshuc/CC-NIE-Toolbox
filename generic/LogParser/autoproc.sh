#!/bin/bash
##
# Copyright (C) 2015 University of Virginia. All rights reserved.
#
# @file      autoproc.sh
# @author    Shawn Chen <sc7cq@virginia.edu>
# @version   1.0
# @date      July 8, 2015
#
# @section   LICENSE
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation; either version 2 of the License, or（at your option）
# any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
# more details at http://www.gnu.org/copyleft/gpl.html
#
# @brief     Automatically parses the raw log file and generates csv.
# @usage     ./autoproc.sh <basename-of-logfile> <basename-of-csv-file>


filebase=$1
logbase=$2
log=".log"
rawcsv="-raw.csv"

# parses all the raw log files one by one
for i in {1..10}
do
    echo "---------- processing log$i ----------"
    python recvLogParser.py $filebase$i$log $logbase$i$rawcsv
done


csv=".csv"
#host="PSC,"
host="UCD,"
# delay and loss both in percentage
delay="0,"
loss="0,"
# RTT in ms
rtt="90,"

# concatenates the constant columns to each csv
for i in {1..10}
do
    while IFS='' read -r line || [[ -n $line ]]; do
        echo "$host$delay$loss$rtt$line" >> "$logbase$i$csv"
    done < "$logbase$i$rawcsv"
done

# clean up
mkdir ucd-csv
rm *raw.csv
mv *.csv ucd-csv
