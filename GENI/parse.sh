#!/bin/bash

nohup scl enable python27 'cd ~/vcmtp/VCMTPv3/receiver/logs/ && sh autoproc_pergroup.sh day1NGRID.data VCMTPv3_RECEIVER_centos_run 20 WAN' &> /dev/null &
