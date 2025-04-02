library("rgl")
library("vegan")
library("vegan3d")
library("scatterplot3d")


round(cor(lakedata), 2)


par(mfrow=c(2,2), mar=c(4,4,1,1)+.1)
plot(log(z_max) ~ log(z_mean), data=lakedata, pch=16)

plot(log(z_max) ~ log(volume), data=lakedata, pch=16)

plot(log(volume) ~ log(z_mean), data=lakedata, pch=16)

with(lakedata, scatterplot3d(log(z_mean), log(z_max), log(volume), pch=16, type="h"))


A <- with(lakedata, data.frame(
  log_z_mean = log(z_mean),
  log_z_max  = log(z_max),
  log_volume = log(volume)
))

ordirgl(A, type="p", ax.col = "black", col="red", box=FALSE)
view3d(theta = 5, phi = 15, fov=30, zoom=0.7)
axes3d(labels=FALSE)


pc <- rda(A)
ordirgl(pc, type="p", display="sites", 
        ax.col = "black", col="red", xlim=c(0,6), ylim=c(0,6), zlim=c(0,6))
view3d(theta = 0, phi = 0, fov=0, zoom=0.7)
axes3d()
