#!/bin/bash

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
