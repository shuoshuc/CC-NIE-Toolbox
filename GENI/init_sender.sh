#!/bin/bash

# Copyright (C) 2015 University of Virginia. All rights reserved.
#
# @file      init_sender.sh
# @author    Shawn Chen <sc7cq@virginia.edu>
# @version   1.0
# @date      August 22, 2015
#
# @section   LICENSE
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# @brief    GENI node initialization for sender.


yum -y update
yum -y install mosh
ntpdate pool.ntp.org
cp CC-NIE-Toolbox/GENI/sysctl.conf /etc
sysctl -p
const="inet addr:"
bindip=`hostname -I | awk -F ' ' '{print $2}'`
iface=$(ifconfig | grep -B1 "$const$bindip" | awk '$1!="inet" && $1!="--" {print $1}')
export NIC=$iface
route add 224.0.0.1 dev $NIC

rvlan=100mbit
rsnd=40mbit
residue=60mbit

tc qdisc add dev $NIC root handle 1: htb default 2
tc class add dev $NIC parent 1: classid 1:1 htb rate $rsnd ceil $rsnd
tc qdisc add dev $NIC parent 1:1 handle 10: bfifo limit 600mb
tc class add dev $NIC parent 1: classid 1:2 htb rate $residue ceil $residue
tc qdisc add dev $NIC parent 1:2 handle 11: bfifo limit 600mb

tc filter add dev $NIC protocol ip parent 1:0 prio 1 u32 match ip dst 224.0.0.1/32 flowid 1:1
tc filter add dev $NIC protocol ip parent 1:0 prio 1 u32 match ip dst 0/0 flowid 1:2

git clone https://github.com/Unidata/vcmtp.git
