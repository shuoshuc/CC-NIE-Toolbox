par(mar=c(6.1,6.5,4.1,2.1))
plot(real_8G[1:200], type='l', col='red', xlim=c(0,250), ylim=c(0,6) ,lwd=3,
     xlab = 'File Index', ylab = 'Latency (ms)', cex.lab=1.5, cex.axis=1.5)
lines(real_500M[1:200], type='l', col='blue', ylim=c(0,6), lwd=3)
lines(ideal_500M[1:200], type='l', col='green', ylim=c(0,6), lwd=3)
lines(ideal_8G[1:200], type='l', col='purple', ylim=c(0,6), lwd=3)