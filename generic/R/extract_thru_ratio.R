##
# Copyright (C) 2015 University of Virginia. All rights reserved.
#
# @file      extract_thru_ratio.R
# @author    Shawn Chen <sc7cq@virginia.edu>
# @version   1.0
# @date      August 16, 2015
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
# @brief   Extracts the successful throughput and block retransmission ratio.


path <- "~/Workspace/VCMTP_LOG/"
expt <- "11"
node <- "1"
host <- "OSF"
prefix <- paste(path, "Expt-", expt, "/recv-node", node, "/", sep="")
filename <- paste("Expt", expt, "-", host, "-run", sep="")
varprefix <- paste("Expt", expt, "_recvnode", node, "_run", sep="")
ratiomatrix <- paste("Expt", expt, "_recvnode", node, "_ratiomatrix", sep="")
thrumatrix <- paste("Expt", expt, "_recvnode", node, "_thrumatrix", sep="")
thru_mat <- numeric()
ratio_mat <- numeric()
thru <- numeric()
for(i in 1:10)
{
  csvname <- paste(prefix, filename, i, sep="")
  varname <- paste(varprefix, i, sep="")
  thru_s <- paste(varname, "_thru_s", sep="")
  block_retx_ratio <- paste(varname, "_ratio", sep="")
  assign(varname, read.csv(paste(csvname, ".csv", sep="")))
  # convert from bps to Mbps
  assign(thru_s, get(varname)[[6]] / 1000000)
  assign(block_retx_ratio, get(varname)[[13]])
  thru_mat <- rbind(thru_mat, get(varname)[[6]] / 1000000)
  ratio_mat <- rbind(ratio_mat, get(varname)[[13]])
}
assign(ratiomatrix, ratio_mat)
assign(thrumatrix, thru_mat)


# For plot
options(scipen=10)
#red
boxplot(t(Expt11_recvnode1_thrumatrix), las = 1, outline = FALSE)
#blue
boxplot(t(Expt11_recvnode2_thrumatrix), las = 1, outline = FALSE)
title('', xlab='',
      ylab='')
mtext('')
