
## triangle
plot(NULL, xlim=c(0,10), ylim=c(0,10), axes=FALSE, type="n", xlab="", ylab="")
polygon(c(1,8,10,1), c(1,1,10,1), lwd=2)
text(c(5,9.5,5), c(0,5,6), c("a", "b", "c"), cex=2)


## kartesian
plot(NULL, xlim=c(0,10), ylim=c(0,10), las=1, type="n", xlab="x", ylab="y")

x <- c(2, 8)
y <- c(1, 7)
points(x, y, pch=16, cex=2, type="b", lwd=2)
text(x, y + 0.2, c("A", "B"), cex=2, pos=3)
lines(c(x, x[2]), c(y[1], y[1], y[2]))
text(mean(x), y[1], "a", pos=1, cex=2)
text(x[2], mean(y), "b", pos=4, cex=2)
text(mean(x), mean(y), "c", pos=3, cex=2)
