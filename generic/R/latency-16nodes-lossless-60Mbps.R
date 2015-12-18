par(mfrow=c(2,4), mar=c(5,5,4,2))
hist(ldm6_21, xlim=c(0,10), breaks=80, ylim=c(0,15000), xlab='Latency (s)',
     main='LDM6 (OSF)', cex.lab=1.5, cex.axis=1.5, cex.main=1.5)
hist(ldm6_35, xlim=c(0,10), breaks=80, ylim=c(0,15000), xlab='Latency (s)',
     main='LDM6 (UH)', cex.lab=1.5, cex.axis=1.5, cex.main=1.5)
hist(ldm6_50, xlim=c(0,10), breaks=80, ylim=c(0,20000), xlab='Latency (s)',
     main='LDM6 (WSU)', cex.lab=1.5, cex.axis=1.5, cex.main=1.5)
hist(ldm6_5, xlim=c(0,10), breaks=80, ylim=c(0,15000), xlab='Latency (s)',
     main='LDM6 (SL)', cex.lab=1.5, cex.axis=1.5, cex.main=1.5)
hist(ldm7_21, breaks=40, xlab='Latency (s)', main='LDM7 (OSF)', xlim=c(0,10),
     ylim=c(0,25000), cex.lab=1.5, cex.axis=1.5, cex.main=1.5)
hist(ldm7_35, breaks=40, xlab='Latency (s)', main='LDM7 (UH)', xlim=c(0,10),
     ylim=c(0,25000), cex.lab=1.5, cex.axis=1.5, cex.main=1.5)
hist(ldm7_50, breaks=80, xlab='Latency (s)', main='LDM7 (WSU)', xlim=c(0,10),
     ylim=c(0,25000), cex.lab=1.5, cex.axis=1.5, cex.main=1.5)
hist(ldm7_5, breaks=40, xlab='Latency (s)', main='LDM7 (SL)', xlim=c(0,10),
     ylim=c(0,25000), cex.lab=1.5, cex.axis=1.5, cex.main=1.5)