#!/bin/bash
# create on July 1, 2015
# By Shawn Chen <schen@virginia.edu>
# Extracts timestamps from pcap files

pcapname=$1
logfile=$2
tshark -T fields -e frame.time_relative -r $1 > $2
