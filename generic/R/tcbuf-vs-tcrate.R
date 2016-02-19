par(mar=c(6.1,6.5,4.1,2.1))
r_mc <- c(20, 30, 40, 50, 100, 200)
plot(r_mc, buf_vec, type='o', col='red', lwd=3,
     xlab='Multicast rate r_mc (Mbps)', ylab='Minimum loss-free buffer size (MB)',
     cex.lab=1.5, cex.axis=1.5)
grid()