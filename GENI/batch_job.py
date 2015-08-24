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

import sys
from fabric.api import env, run

def read_hosts():
    """
    Reads hosts IP from sys.stdin line by line, expecting one per line.
    """
    env.hosts = []
    for line in sys.stdin.readlines():
        host = line.strip()
        if host and not host.startswith("#"):
            host = 'root@' + host
            env.hosts.append(host)

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

def query_send():
    run('tail -n 3 ~/vcmtp/VCMTPv3/sender/*.log')

def query_recv():
    run('tail -n 3 ~/vcmtp/VCMTPv3/receiver/logs/*.log')

def terminate_recv():
    run('pkill testRecvApp')
    run('rm -r ~/vcmtp')

def simple_task():
    run("uptime")
