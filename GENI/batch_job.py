#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""@package perGroupParser
Copyright (C) 2015 University of Virginia. All rights reserved.

file      batch_job.py
author    Shawn Chen <sc7cq@virginia.edu>
version   1.0
date      August 23, 2015

LICENSE
This program is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2 of the License, or（at your option）
any later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
more details at http://www.gnu.org/copyleft/gpl.html

brief     Launches batch job for VCMTP test experiments.
"""

from fabric.api import run

def runexpt_send():
    run('git clone https://github.com/shawnsschen/CC-NIE-Toolbox.git')
    run('git clone https://github.com/Unidata/vcmtp.git')
    run('cp ~/CC-NIE-Toolbox/GENI/day1NGRID_400min.csv ~/vcmtp/VCMTPv3/sender/day1NGRID.csv')
    run('cd ~/vcmtp/VCMTPv3/sender/ && make -f Makefile_send')
    run('cd ~/vcmtp/VCMTPv3/sender/ && ./startTestSendApp.sh', pty=False)

def runexpt_recv():
    run('git clone https://github.com/Unidata/vcmtp.git')
    run('cd ~/vcmtp/VCMTPv3/receiver/ && make -f Makefile_recv')
    run('cd ~/vcmtp/VCMTPv3/receiver/ && ./startTestRecvApp.sh', pty=False)
