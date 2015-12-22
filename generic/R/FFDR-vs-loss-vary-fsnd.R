par(mar=c(6.1,6.5,4.1,2.1))
plot(c(0,0.5,1.0,1.5,2.0), m16_5k, type='o', col='blue3', pch=22,
     xlab='Packet Loss Rate (%)', ylab='FFDR (%)', cex.lab=1.5, cex.axis=1.5, lwd=3)
lines(c(0,0.5,1.0,1.5,2.0), m8_5k, type='o', col='brown1', pch=25, lty=2, lwd=3)
grid()