#!/bin/bash
##
# Copyright (C) 2015 University of Virginia. All rights reserved.
#
# @file      autoproc_pergroup.sh
# @author    Shawn Chen <sc7cq@virginia.edu>
# @version   1.0
# @date      July 20, 2015
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
# @usage     ./autoproc_pergroup.sh <metadata> <basename-of-logfile> \
#            <experiment number> <hostname>


export metadata=$1
export filebase=$2
export exptno=$3
export host=$4
CORENUM=10

parselog() {
    echo "---------- processing log$1 ----------"
    python2.7 perGroupParser.py $metadata $filebase$1'.log' 'Expt'$exptno'-'$host'-run'$1'.csv'
}
export -f parselog

# parses all the raw log files in parallel (using $CORENUM processes)
seq 1 10 | xargs -n 1 -P $CORENUM bash -c 'parselog "$@"' --

# clean up
mkdir csv
mv *.csv csv
