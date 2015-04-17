##
# Copyright (C) 2015 University of Virginia. All rights reserved.
#
# @file      pareto_fit.R
# @author    Shawn Chen <sc7cq@virginia.edu>
# @version   1.0
# @date      Apr. 16, 2015
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
# @brief     reads source data and use pareto model to fit it.


# read source data from a csv file (path might need to be changed)
sizes <- read.csv('~/Workspace/VCMTP_LOG/ldm-metadata/size.csv')
# transposition of frame
size <- t(sizes)
# cast into vector
sizevec <- as.vector(size)
# use fitdistrplus package to fit pareto distribution
fp <- fitdist(sizevec, 'pareto', start=c(shape=3, scale=min(sizevec)), discrete=TRUE)
