group_size <- 1000
rates <- numeric()
data <- read.csv('~/prodsrc-7hr.log', sep = ':', comment.char = '#')
y <- ifelse(data[[1]] == 'VCMTP', 1, 0)
groups <- split(y, ceiling(seq_along(y)/group_size))
for (i in 1:length(groups))
{
  rate <- sum(groups[[i]]) / length(groups[[i]]) * 100
  rates[i] <- rate
  print(rate)
}
plot(rates, pch=16, type="h", xlab = 'Aggregate group',
     ylab = 'VCMTP-sourced rate (%)')
title('Grouped VCMTP-sourced rates')
