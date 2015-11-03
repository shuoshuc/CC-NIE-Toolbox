#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""@package deploy_LDM7
Copyright (C) 2015 University of Virginia. All rights reserved.

file      deploy_LDM7.py
author    Shawn Chen <sc7cq@virginia.edu>
version   1.0
date      Oct. 28, 2015

LICENSE
This program is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2 of the License, or（at your option）
any later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
more details at http://www.gnu.org/copyleft/gpl.html

brief     Installs and deploys LDM7 on the testbed.
"""

import logging
import sys
from StringIO import StringIO
from fabric.api import env, run, cd, get, sudo, put
from fabric.context_managers import settings

logging.basicConfig()
paramiko_logger = logging.getLogger("paramiko.transport")
paramiko_logger.disabled = True

LDM_VER = 'ldm-6.12.15.37'
LDM_PACK_NAME = LDM_VER + '.tar.gz'
LDM_PACK_PATH = '~/'

def read_hosts():
    """
    Reads hosts IP from sys.stdin line by line, expecting one per line.
    Then appends the username to each IP address.
    """
    env.hosts = []
    for line in sys.stdin.readlines():
        host = line.strip()
        if host and not host.startswith("#"):
            host = 'root@' + host
            env.hosts.append(host)

def clear_home():
    """
    Clears the ldm user home directory, including the existing product queue.
    """
    with cd('/home/ldm'):
        run('rm -rf *')

def upload_pack():
    """
    Uploads the LDM source code package onto the test node. Also uploads a
    LDM start script.
    """
    put(LDM_PACK_PATH + LDM_PACK_NAME, '/home/ldm', mode=0664)
    put('~/Workspace/CC-NIE-Toolbox/generic/misc/util/', '/home/ldm',
        mode=0664)
    with cd('/home/ldm'):
        run('chown ldm.ldm %s' % LDM_PACK_NAME)
        run('chmod +x util/run_ldm util/insert.sh')
        run('chown -R ldm.ldm util')

def install_pack():
    """
    Compiles and installs the LDM source code.
    """
    with settings(sudo_user='ldm'):
        with cd('/home/ldm'):
            sudo('gunzip -c %s | pax -r \'-s:/:/src/:\'' % LDM_PACK_NAME)
        with cd('/home/ldm/%s/src' % LDM_VER):
            sudo('make distclean', quiet=True)
            sudo('./configure --with-debug --with-multicast \
                 --disable-root-actions --prefix=/home/ldm \
                 CFLAGS=-g CXXFLAGS=-g')
            sudo('make install')
            run('make root-actions')

def init_config():
    """
    Configures the etc file and environment variables. Also sets up tc and
    routing table on the sender.
    """
    run('service ntpd start', quiet=True)
    iface = run('hostname -I | awk \'{print $2}\'')
    if iface == '10.10.1.1':
        config_str = ('MULTICAST ANY 224.0.0.1:38800 1 10.10.1.1\n'
                      'ALLOW ANY ^.*$\nEXEC \"insert.sh\"')
        run('route add 224.0.0.1 dev eth1', quiet=True)
        run('tc qdisc add dev eth1 root handle 1: htb default 2', quiet=True)
        run('tc class add dev eth1 parent 1: classid 1:1 htb rate 40mbit \
            ceil 40mbit', quiet=True)
        run('tc qdisc add dev eth1 parent 1:1 handle 10: bfifo limit 600mb',
            quiet=True)
        run('tc class add dev eth1 parent 1: classid 1:2 htb rate 40mbit \
            ceil 40mbit', quiet=True)
        run('tc qdisc add dev eth1 parent 1:2 handle 11: bfifo limit 600mb',
            quiet=True)
        run('tc filter add dev eth1 protocol ip parent 1:0 prio 1 u32 match \
            ip dst 224.0.0.1/32 flowid 1:1', quiet=True)
        run('tc filter add dev eth1 protocol ip parent 1:0 prio 1 u32 match \
            ip dst 0/0 flowid 1:2', quiet=True)
        with cd('/home/ldm'):
            sudo('git clone \
                 https://github.com/shawnsschen/LDM6-LDM7-comparison.git',
                 user='ldm', quiet=True)
    else:
        config_str = 'RECEIVE ANY 10.10.1.1 ' + iface
    fd = StringIO()
    get('/home/ldm/.bashrc', fd)
    content=fd.getvalue()
    if 'ulimit -c "unlimited"' in content:
        update_bashrc = True
    else:
        update_bashrc = False
    get('/home/ldm/.bash_profile', fd)
    content=fd.getvalue()
    if 'export PATH=$PATH:$HOME/util' in content:
        update_profile = True
    else:
        update_profile = False
    with settings(sudo_user='ldm'):
        with cd('/home/ldm'):
            sudo('echo \'%s\' > etc/ldmd.conf' % config_str)
            if not update_bashrc:
                sudo('echo \'ulimit -c "unlimited"\' >> .bashrc')
            if not update_profile:
                sudo('echo \'export PATH=$PATH:$HOME/util\' >> .bash_profile')
        sudo('regutil -s %s /hostname' % iface)
        sudo('regutil -s 5G /queue/size')
        sudo('regutil -s 35000 /queue/slots')

def start_LDM():
    """
    Start LDM and writes log file to a specified location.
    """
    with settings(sudo_user='ldm'), cd('/home/ldm'):
        sudo('run_ldm ldmd_test')

def stop_LDM():
    """
    Stops running LDM.
    """
    with settings(sudo_user='ldm'), cd('/home/ldm'):
        sudo('ldmadmin stop')

def deploy():
    clear_home()
    upload_pack()
    install_pack()
    init_config()