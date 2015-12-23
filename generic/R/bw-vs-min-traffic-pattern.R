# generate plot as 9 : 13.5
par(mfrow=c(2,1), mar=c(5,5,4,1))
plot(1:59, bw6, col='red', type='l', lwd=3, lty=5, xlab='Minutes',
     ylab='BW (Mbps)', main='Sender NIC Bandwidth (BW) Utilization', cex.lab=1.5,
     cex.axis=1.5, cex.main=1.5)
lines(1:59, bw7, col='blue', type='l', lwd=3)
plot(1:60, data, type='h', lwd=3, xlab='Minutes', ylab='Agg. Size (MB)',
     main='File-Stream Traffic Pattern', cex.lab=1.5, cex.axis=1.5, cex.main=1.5)