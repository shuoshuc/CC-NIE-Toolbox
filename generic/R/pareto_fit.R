sizes <- read.csv('~/Workspace/VCMTP_LOG/ldm-metadata/size.csv')
size <- t(sizes)
sizevec <- as.vector(size)
fp <- fitdist(sizevec, 'pareto', start=c(shape=3, scale=min(sizevec)), discrete=TRUE)