library("mvtnorm")

#set.seed(123)
#x <- rmvnorm(n=50, mean=c(5,5), sigma=matrix(c(2,1.6,1.6,2), ncol=2))

col <- c("red", "cyan", "violet")

rotate_pc <- function(x, pc=c(1, 2), ...) {
  p <- prcomp(x)
  l <- p$rotation #loadings(p)
  a <- p$center

  plot(x, las=1, pch=16, ...)
  abline(lm(x[,2] ~ x[,1]), col="blue", lty="dotted", lwd=2)
  
  b1 <- l[2,1]/l[1,1]
  abline(a=a[2] - b1*a[1], b=b1, col=col[pc[1]], lwd=2)
  
  b2 <-  l[2,2]/l[1,2]
  abline(a=a[2] - b2*a[1], b=b2, col=col[pc[2]], lwd=2)
  
  legend("bottomright", c(paste("PC", pc[1]), paste("PC", pc[2]), "lm"), 
         col=c(col[pc[1]], col[pc[2]], "blue"), lwd=2,
         lty=c("solid","solid","dotted"), bty="o", bg="white")
}

par(mfrow=c(2, 2))
par(mar=c(4.1, 5.1, 2.1, 1.1))

rotate_pc(A[,1:2], 1:2, xlim=c(0,10), ylim=c(0,10))
rotate_pc(A[,c(3,1)], c(3,1), xlim=c(-5,5), ylim=c(0,10))
rotate_pc(A[,c(2,3)], c(2,3), xlim=c(0,10), ylim=c(-5,5))

p <- prcomp(A)
#biplot(p)

plot(p$x[,1], p$x[,2], pch=16, col="blue", xlab="PC 1", ylab= "PC 2")
abline(h=0, col=col[1], lwd=2)
abline(v=0, col=col[2], lwd=2)
