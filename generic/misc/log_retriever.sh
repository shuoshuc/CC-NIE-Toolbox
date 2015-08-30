#!/bin/bash
##
# Copyright (C) 2015 University of Virginia. All rights reserved.
#
# @file      log_retriever.sh
# @author    Shawn Chen <sc7cq@virginia.edu>
# @version   1.0
# @date      August 30, 2015
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
# @brief     Reads the receiver nodes IP list and fetches the logs.

UMass="205.172.170"
TAMU="128.194.6"
SL="165.124.159"
WSU="141.217.114"

while IFS='' read -r line || [[ -n "$line" ]]; do
    if [[ $line == \#* ]]; then
        continue
    else
        header="${line%.*}"
        trailer="${line##*.}"
        if [ "$header" == "$UMass" ]; then
            dir="UMass-"$trailer
        elif [ "$header" == "$TAMU" ]; then
            dir="TAMU-"$trailer
        elif [ "$header" == "$SL" ]; then
            dir="SL-"$trailer
        elif [ "$header" == "$WSU" ]; then
            dir="WSU-"$trailer
        else
            echo "No match"
        fi
        echo $dir
        mkdir $dir
        scp root@$line:~/logs.7z $dir
    fi
    break
done < "$1"
