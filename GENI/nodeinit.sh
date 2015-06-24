#!/bin/bash

# Copyright (C) 2015 University of Virginia. All rights reserved.
#
# @file      nodeinit.sh
# @author    Shawn Chen <sc7cq@virginia.edu>
# @version   1.0
# @date      June 24, 2015
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
# @brief    GENI node initialization


yum -y update
wget http://people.centos.org/tru/devtools-1.1/devtools-1.1.repo
cp devtools-1.1.repo /etc/yum.repos.d
yum -y --enablerepo=testing-1.1-devtools-6 install devtoolset-1.1-gcc devtoolset-1.1-gcc-c++
rm /usr/bin/g++
ln -s /opt/centos/devtoolset-1.1/root/usr/bin/g++ /usr/bin
ntpdate -q pool.ntp.org
service ntpd start
cp ~shawn/CC-NIE-Toolbox/ExoGENI/sysctl.conf /etc
sysctl -p
git clone https://github.com/Unidata/vcmtp.git
