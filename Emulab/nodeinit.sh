#!/bin/bash

# Copyright (C) 2014 University of Virginia. All rights reserved.
#
# @file      nodeinit.sh
# @author    Shawn Chen <sc7cq@virginia.edu>
# @version   1.0
# @date      May 23, 2015
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
# @brief    Emulab node initialization


sudo yum -y update
sudo rpm -ivh ~shawn/nuttcp-6.1.2-3.3.x86_64.rpm
sudo cp ~shawn/devtools-1.1.repo /etc
sudo yum -y --enablerepo=testing-1.1-devtools-6 install devtoolset-1.1-gcc devtoolset-1.1-gcc-c++
sudo rm /usr/bin/g++
sudo ln -s /opt/centos/devtoolset-1.1/root/usr/bin/g++ /usr/bin
git clone https://github.com/Unidata/vcmtp.git
git clone https://github.com/shawnsschen/CC-NIE-Toolbox.git
sudo cp ~shawn/CC-NIE-Toolbox/generic/tc/sysctl.conf /etc
sudo sysctl -p
#sudo ethtool -K em4 tso off
#sudo ethtool -K em4 lro off
