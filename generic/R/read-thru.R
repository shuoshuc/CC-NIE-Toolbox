csvpath <- '~/Workspace/LDM6-LDM7-LOG/thru-vs-rate/Lossless-16nodes/LDM7/16nodes-60Mbps/csv/'
csvfiles <- list.files(path = csvpath, pattern = '.csv')
thru_arr <- array()
for (i in 1:length(csvfiles))
{
  assign(csvfiles[i], read.csv(paste(csvpath, csvfiles[i], sep=''))[[5]])
  thru_arr <- cbind(thru_arr, get(csvfiles[i]))
}
thru_arr <- thru_arr[,-1]
avg_thru <- matrix(0, nrow = nrow(thru_arr))
for (i in 1:nrow(thru_arr))
{
  avg_thru[i] <- mean(thru_arr[i,])
}
thru <- mean(avg_thru)/1000