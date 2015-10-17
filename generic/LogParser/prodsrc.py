#!/usr/bin/env python
# -*- coding: utf-8 -*-
##
# Copyright (C) 2015 University of Virginia. All rights reserved.
#
# @file      prodsrc.py
# @author    Shawn Chen <sc7cq@virginia.edu>
# @version   1.0
# @date      Oct. 17, 2015
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
# @brief     parses LDM log file and extracts the source of the product
#            (whether from VCMTP or LDM backstop).
# @usage     python prodsrc.py <logfile-to-read> <newfile-to-write>


from __future__ import division
import re
import sys

def main(filename, newfile):
    vcmtp    = set()
    backstop = set()
    overall  = set()
    with open(filename, 'r') as f:
        for i, line in enumerate(f):
            vcmtpprod = re.findall(r'INFO.*mldm.*Received.*\s{2}(\d+)', line)
            ldmprod   = re.findall(r'INFO.*down7.*Inserted.*\s{2}(\d+)', line)
            # should tolerate the duplicate notification for the same product
            if vcmtpprod:
                for prod in vcmtpprod:
                    vcmtp |= {prod}
                    overall |= {prod}
            if ldmprod:
                for prod in ldmprod:
                    backstop |= {prod}
                    overall |= {prod}
    f.close()
    overall = sorted(overall, key=int)
    with open(newfile, 'w+') as w:
        for i in overall:
            if i in vcmtp:
                w.write('VCMTP:' + str(i) + '\n')
            if i in backstop:
                w.write('BACKSTOP:' + str(i) + '\n')
        vcmtp_src_rate = float(len(vcmtp) / len(overall)) * 100
        w.write('\nVCMTP-sourced rate: ' + str(vcmtp_src_rate) + '\n')
    w.close()

# takes 2 command line arguments, first is log file name, second is the name
# the new file to contain the parsed results.
if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
