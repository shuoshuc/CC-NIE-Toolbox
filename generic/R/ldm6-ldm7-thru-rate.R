csvpath <- '~/Workspace/LDM6-LDM7-LOG/WAN-8nodes-LDM6/WAN-8nodes-10Mbps/csv/'
ldm6 <- matrix(0, nrow = 6)
ldm7 <- matrix(0, nrow = 7)
for (n in 1:6)
{
  csvfiles <- list.files(path = csvpath, pattern = '.csv')
  thru_arr <- array()
  for (i in 1:length(csvfiles))
  {
    assign(csvfiles[i], read.csv(paste(csvpath, csvfiles[i], sep=''))[['Throughput..bps.']])
    thru_arr <- cbind(thru_arr, get(csvfiles[i]))
  }
  thru_arr <- thru_arr[,-1]
  avg_thru <- matrix(0, nrow = nrow(thru_arr))
  for (i in 1:nrow(thru_arr))
  {
    avg_thru[i] <- mean(thru_arr[i,])
  }
  ldm6[n] <- mean(avg_thru)
  csvpath <- gsub(toString(n*10), toString((n+1)*10), csvpath)
}
