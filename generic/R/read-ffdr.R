csvpath <- '~/Workspace/LDM6-LDM7-LOG/FFDR-vs-loss/16nodes-20Mbps-fsnd1000000/16nodes-20Mbps-0.02loss/csv/'
csvfiles <- list.files(path = csvpath, pattern = '.csv')
ffdr_arr <- array()
for (i in 1:length(csvfiles))
{
  assign(csvfiles[i], read.csv(paste(csvpath, csvfiles[i], sep=''))[[6]])
  ffdr_arr <- cbind(ffdr_arr, get(csvfiles[i]))
}
ffdr_arr <- ffdr_arr[,-1]
avg_ffdr <- matrix(0, nrow = nrow(ffdr_arr))
for (i in 1:nrow(ffdr_arr))
{
  avg_ffdr[i] <- mean(ffdr_arr[i,])
}
ffdr <- mean(avg_ffdr)