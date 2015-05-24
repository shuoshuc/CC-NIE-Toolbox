##
# Copyright (C) 2015 University of Virginia. All rights reserved.
#
# @file      throughput.R
# @author    Shawn Chen <sc7cq@virginia.edu>
# @version   1.0
# @date      May 19, 2015
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
# @brief     Compute the throughput of a given testcase, model is from Jie's
#            FMTP paper.


# users can tune this variable to read csv data from different test cases
testcase <- 'loss5_size100_factor10_15nodes'
nodename <- paste('rawcsv_node', 0:14, sep = '')
filename <- paste('node', 0:14, '-noloss.csv', sep = '')
# construct the csv file path
path <- paste('~/emulab_logs/', testcase, '/noloss-csv/', filename, sep = '')
rates <- list()

for (i in 1:15)
{
  # first check if the constructed csv filename exists
  # if so, then read it
  if (file.exists(path[i])) {
    # read csv file into the workspace
    rawcsv <- read.csv(path[i])
    assign(nodename[i], rawcsv)
    # get the summary of size
    sumsize <- sum(rawcsv[1])
    # get the summary of time
    sumtime <- sum(rawcsv[2])
    # size/time*8 converts Bps to bps
    tmprate <- (sumsize/sumtime)*8
    # append the receiving rate of a node to the list
    rates[[nodename[i]]] <- tmprate
  }
}
# compute the overall throughput in this current testcase
# refer to Jie Li's FMTP paper, page 8, equation 2.
throughput <- Reduce('+', rates)/length(rates)
