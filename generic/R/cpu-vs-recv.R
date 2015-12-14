par(mar=c(6.1,6.5,4.1,2.1))
plot(c(4,8,12,16,20,24), ldm6_1, type='o', col='blue3', pch=22, lwd=3,
     cex.lab=1.5, cex.axis=1.5, xlab='Number of Receivers',
     ylab='CPU Utilization (%)', ylim=c(0,6), xaxp=c(4,24,5))
lines(c(4,8,12,16,20,24), ldm6_0, type='o', col='brown1', pch=25, lty=2, lwd=3)
lines(c(4,8,12,16,20,24), ldm7_0, type='o', col='forestgreen', pch=8, lty=5, lwd=3)
lines(c(4,8,12,16,20,24), ldm7_1, type='o', col='gold1', pch=1, lty=6, lwd=3)
grid()