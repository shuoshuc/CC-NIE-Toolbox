#!/bin/bash
##
# Copyright (C) 2015 University of Virginia. All rights reserved.
#
# @file      split.sh
# @author    Shawn Chen <sc7cq@virginia.edu>
# @version   1.0
# @date      August 3, 2015
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
# @brief     Splits a large log file into several small ones.
# @usage     ./split.sh <large log> <new log prefix>
# @example   ./split.sh VCMTP_RECV.log VCMTP_run

orig_log=$1
prefix=$2
# counts the total line number in original log file
linenum=$(wc -l $orig_log | awk -F " " '{print $1}')
# parses out the beginning line numbers
begin=$(grep -n -E "\[MCAST\ BOP\].*\#0" $orig_log | awk -F ":" '{print $1}')
# counts number of runs in the original log
count=$(echo $begin | wc -w)
# constructs the ending line numbers
for line in $begin; do
    line=$(( line - 1 ))
    if [ $line -eq 0 ]; then
        continue;
    fi
    end="$end $line"
done
end="$end $linenum"

# cuts the log of each run and saves to a new log
for run in $(seq 1 $count); do
    echo "----- Processing Run $run -----"
    b=$(echo $begin | awk -v col=$run -F " " '{print $col}')
    e=$(echo $end | awk -v col=$run -F " " '{print $col}')
    newlog="$prefix$run.log"
    sed -n ${b},${e}p $orig_log > $newlog
done
