rates <- numeric()
agg <- read.csv('~/agg.csv', sep = ',', comment.char = '#')
start <- agg[[1]]
end <- agg[[2]]
data <- read.csv('~/prodsrc-7hr.log', sep = ':', comment.char = '#')
y <- ifelse(data[[1]] == 'VCMTP', 1, 0)
x <- data[[2]]
for (i in 1:nrow(agg))
{
  start_id <- 0
  end_id <- 0
  row_id <- match(start[i], x)
  if (is.na(row_id)) {
    start_id <- which.min(abs(x - start[i]))
  }
  else {
    start_id <- row_id
  }
  row_id <- match(end[i], x)
  if (is.na(row_id)) {
    end_id <- which.min(abs(x - end[i]))
  }
  else {
    end_id <- row_id
  }
  rates[i] <- sum(y[start_id:end_id]) / length(y[start_id:end_id]) * 100
}
plot(rates, pch=16, type="h", xlab = 'Aggregate group',
     ylab = 'VCMTP-sourced rate (%)')
title('Grouped VCMTP-sourced rates (7-hr NGRID)')
