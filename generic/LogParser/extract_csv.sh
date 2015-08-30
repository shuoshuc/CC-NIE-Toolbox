#!/bin/bash
##
# Copyright (C) 2015 University of Virginia. All rights reserved.
#
# @file      extract_csv.sh
# @author    Shawn Chen <sc7cq@virginia.edu>
# @version   1.0
# @date      August 29, 2015
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
# @brief     Extracts csv results from the compressed 7zip file.

DIRPATH=`pwd`
for dir in $DIRPATH/*
do
    if [ -d $dir ]; then
        cd $dir
    else
        continue
    fi
    for subdir in `pwd`/*
    do
        echo $subdir
        7z x $subdir/logs.7z -o$subdir/tmp/ csv/ -r
        mv $(find $subdir -name "*.csv") $subdir
        rm -r $subdir/tmp/
        rm $subdir/logs.7z
    done
done
