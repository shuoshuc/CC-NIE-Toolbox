##
# Copyright (C) 2015 University of Virginia. All rights reserved.
#
# @file      thru_vs_aggregate.R
# @author    Shawn Chen <sc7cq@virginia.edu>
# @version   1.0
# @date      July 20, 2015
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
# @brief     Plot the throughput against aggregate size graph.


prefix <- "~/Workspace/VCMTP_LOGS/ExoGENI/july8-2015-UMass-UCD-PSC/PSC/
           allcsv/csv-1MB/"
filename <- "Expt1-PSC-run"
varprefix <- "Expt1_PSC_run"
thru_1MB <- numeric()
for(i in 1:10)
{
  fullname <- paste(prefix, filename, sep="")
  varname <- paste(varprefix, i, sep="")
  oname <- paste(fullname, i, sep="")
  assign(varname, read.csv(paste(oname, ".csv", sep="")))
  assign(varname, get(varname)[[5]])
  # merge throughput into a vector
  thru_1MB <- c(thru_1MB, get(varname))
  # convert throughput from bps to Mbps
  thru_1MB <- thru_1MB / 1000000
}
