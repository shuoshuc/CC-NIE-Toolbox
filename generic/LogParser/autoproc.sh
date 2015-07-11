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
csv=".csv"

# parses all the raw log files one by one
#for i in {1..10}
for i in {1..1}
do
    echo "---------- processing log$i ----------"
    python recvLogParser.py $filebase$i$log $logbase$i$csv
    sed -i -e \
        '1ithroughput (bps), reliability (%), block retransmission rate (%)\' \
        $logbase$i$csv
done

# clean up
mkdir csv
mv *.csv csv
