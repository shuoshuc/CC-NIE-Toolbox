#!/bin/bash

pcapname=$1
logfile=$2
tshark -T fields -e frame.time_relative -r $1 > $2
