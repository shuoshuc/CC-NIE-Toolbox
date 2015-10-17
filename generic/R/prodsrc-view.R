rates <- numeric()
total <- 0
hit <- 0
agg <- read.csv('~/agg.csv', sep = ',', comment.char = '#')
start <- agg[[1]]
end <- agg[[2]]
data <- read.csv('~/prodsrc-7hr.log', sep = ':', comment.char = '#')
y <- ifelse(data[[1]] == 'VCMTP', 1, 0)
x <- data[[2]]
for (i in 1:nrow(agg))
{
  for (j in start[i]:end[i])
  {
    row_id <- match(j, x)
    if (!is.na(row_id))
    {
      total <- total + 1
      if (y[row_id] == 1)
      {
        hit = hit + 1
      }
    }
  }
  rates[i] <- hit / total * 100
  print(rates[i])
  total <- 0
  hit <- 0
}
plot(rates, pch=16, type="h", xlab = 'Aggregate group',
     ylab = 'VCMTP-sourced rate (%)')
title('Grouped VCMTP-sourced rates')
