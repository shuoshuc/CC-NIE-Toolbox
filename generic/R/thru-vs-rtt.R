par(mar=c(6.1,6.5,4.1,2.1))
plot(c(1, 10, 20, 50, 100), rtt500, type='o', col='red', lwd=3, xlab='RTT (ms)',
     ylab='Aggregate Throughput (Mbps)', cex.lab=1.5, cex.axis=1.5, pch=21)
lines(c(1, 10, 20, 50, 100), rtt20, type='o', col='blue', lwd=3, pch=24)
legend('topright', col=c('red', 'blue'), c('500 Mbps', '20 Mbps'),
       lty=1, pch=c(21, 24), lwd=3)
grid()