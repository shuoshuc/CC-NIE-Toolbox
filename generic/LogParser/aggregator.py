#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""@package perGroupParser
Copyright (C) 2015 University of Virginia. All rights reserved.

file      aggregator.py
author    Shawn Chen <sc7cq@virginia.edu>
version   1.0
date      Oct. 17, 2015

LICENSE

This program is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2 of the License, or（at your option）
any later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
more details at http://www.gnu.org/copyleft/gpl.html

brief     Aggregates over the metadata.
usage     python aggregator.py <metadata> <csvfile-to-write>
"""


from __future__ import division
import csv
import re
import sys


def aggregate(filename, aggregate_size):
    """Does aggregating on the given input csv.

    Does size aggregating over a csv file that contains sizes of products in
    the first column and returns the aggregate results.

    Args:
        filename: Filename of the csv file.
        aggregate_size: The size of each aggregate group.

    Returns:
        (groups, sizes): A list of aggregated groups.
    """
    groups   = []
    group    = []
    sizes    = []
    sum_size = 0
    with open(filename, 'rb') as csvfile:
        csvreader = csv.reader(csvfile, delimiter=',')
        for i, row in enumerate(csvreader):
            group.append(i)
            sum_size += int(row[0])
            if sum_size >= aggregate_size:
                groups.append(group)
                sizes.append(sum_size)
                group    = []
                sum_size = 0
        if group and sum_size:
            groups.append(group)
            sizes.append(sum_size)
    csvfile.close()
    return (groups, sizes)


def main(metadata, csvfile):
    """Reads the raw log file and parses it.

    Reads the raw VCMTPv3 log file, parses each line and computes throughput,
    block-based retransmission rate and FDSR over an aggregate size.

    Args:
        metadata: Filename of the metadata.
        logfile: Filename of the log file.
        csvfile : Filename of the new file to contain output results.
    """
    w = open(csvfile, 'w+')
    aggregate_size = 200 * 1024 * 1024
    (tx_groups, tx_sizes) = aggregate(metadata, aggregate_size)
    tmp_str = 'Sent first prodindex, Sent last prodindex, Sender aggregate ' \
              'size (B)' + '\n'
    w.write(tmp_str)
    for group, size in zip(tx_groups, tx_sizes):
        tmp_str = str(min(group)) + ',' + str(max(group)) + ',' \
                + str(size) + '\n'
        w.write(tmp_str)
    w.close()


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
