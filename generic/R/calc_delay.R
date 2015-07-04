ngrid <- read.csv('~/Workspace/IDD_replay/day1NGRID.csv')
arrival <- ngrid[2]
# cumulative arrival time (one hour)
cumulative <- 3600000
# finds the first arrival time that is longer than one hour
one_hr <- min(arrival[apply(arrival, 1, function(row) {all(row > cumulative)}),])
# finds the index of the first match
one_hr_index <- which(one_hr == arrival)
cat('first match:', one_hr)
cat('first match index:', one_hr_index)