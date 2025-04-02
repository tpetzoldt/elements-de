library(dplyr)
library(readr)
library(ggplot2)
library(lubridate)
library(astsa)

co2 <- read_csv("https://gml.noaa.gov/webdata/ccgg/trends/co2/co2_mm_mlo.csv", 
                skip = 40, show_col_types = FALSE) |>
  filter(year > 1958)

co2 |> 
  mutate(date=as_date(paste(year, month, 15, sep="."))) |>
  ggplot(aes(date, average)) + 
  geom_line() + ylab(expression(CO[2]~"in the atmosphere (ppm)")) + 
  ggtitle("Mauna Loa Observatory, Hawaii, Monthly Averages") +
  geom_smooth()

co2ts <- ts(co2$average, start=1959, frequency = 12)

m0 <- sarima(co2ts, p = 1, d = 1, q = 0, P = 1, D = 1, Q = 0, S = 12)

m <- sarima(co2ts, p = 1, d = 1, q = 1, P = 0, D = 1, Q = 1, S = 12)
m$AIC

plot(residuals(m$fit))

predict(m$fit, 12*30)


sarima.for(co2ts, n.ahead = 12 * 77, 
           p = 1, d = 1, q = 1, P = 0, D = 1, Q = 1, S = 12, 
           plot.all = TRUE, pch=16)
