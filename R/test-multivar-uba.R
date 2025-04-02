
library("readxl") # read Excel files directly
library("vegan")  # multivariate statistics in ecology
library("dplyr")


lakes     <- read_excel("../data/3_tab_kenndaten-ausgew-seen-d_2021-04-08.xlsx", range="Tabelle1!B4:O58")
lakenames <- read.csv("../data/lakename-abbreviations.csv")
npchl     <- read.csv("../data/kenndaten-seen-npchl.csv")

names(lakes) <- c("name", "state", "drainage", "population", "altitude", 
                  "z_mean", "z_max", "t_ret", "volume", "area", "shore_length", 
                  "shore_devel", "drain_ratio", "wfd_type")

lakes <- lakes |> 
  left_join(lakenames, by="name") |> 
  left_join(npchl, by="name") |>
  as.data.frame()

row.names(lakes) <- lakes$shortname

valid_columns <- c(
  "name", "shortname",
  "drainage", 
  "population", 
  "altitude", 
  "z_mean",
  "z_max", 
  "t_ret", 
  "volume", 
  "area", 
  "shore_length", 
  "shore_devel", 
  "drain_ratio", 
  "p_tot", 
  "n_no3", 
  "chl",
  "wfd_type")


lakes <- lakes[valid_columns]

write.csv(lakes, file="../data/uba-lakes-combined-data.csv", quote = FALSE, row.names = FALSE)

valid_columns <- c(
  "name", "shortname",
  #"drainage", 
  #"population", 
  #"altitude", 
  "z_mean",
  "z_max", 
  "t_ret", 
  "volume", 
  "area", 
  #"shore_length", 
  #"shore_devel", 
  #"drain_ratio", 
  "p_tot", 
  "n_no3", 
  "chl"
  #"wfd_type"
)


## less columns, so that we get a simplified subset and more complete cases
lakes <- lakes[valid_columns] |> na.omit()

lake_ids <- lakes[c("name", "shortname")]

lakedata <- lakes[, -c(1, 2)]

#lakedata <- apply(lakedata, 2, sqrt)


boxplot(lakedata)
boxplot(scale(lakedata))

lakedata <- log(lakedata)

boxplot(scale(lakedata))

pc <- prcomp(scale(lakedata))

summary(pc)

par(mfrow=c(1, 2))
biplot(pc)
biplot(pc, choices=c(2,3))

par(mfrow=c(1,1))
hc <- hclust(dist(scale(lakedata)))
plot(hc, hang=-1, labels=lake_ids$name)

hc <- hclust(dist(scale(lakedata)), method="ward.D2")
plot(hc, hang=-1, labels=lake_ids$name)
rect.hclust(hc, k=6)
grp <- cutree(hc, k=6)



pc <- rda(scale(lakedata))
summary(pc)$cont$importance

## https://colorbrewer2.org/
colors <- c("blue", "magenta", "forestgreen", "red", "brown", "orange")

biplot(pc, col="black", type="points")
text(pc, display = "species", col="black", pos=3)
text(pc, display = "sites", col=colors[grp], pos=4)

