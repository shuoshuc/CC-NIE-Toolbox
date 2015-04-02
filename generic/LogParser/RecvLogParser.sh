#!/bin/sh
#
# Copyright (C) 2014 University of Virginia. All rights reserved.
#
# @file      RecvLogParser.sh
# @author    Shawn Chen <sc7cq@virginia.edu>
# @version   1.0
# @date      Mar. 31, 2015
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
# @brief    Read raw log file and parse the product size and elapsed time.
#

LOGFILE=$1
cat $1 | grep -E "\(EOP\)" \
       | grep -oE "[0-9]+,|0\.[0-9]*" \
       | sed ':a;N;$!ba;s/,\n/,/g' \
       | sed '1s/^/size(bytes),time(sec)\n/'
