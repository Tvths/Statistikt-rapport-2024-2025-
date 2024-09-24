### stratifierat urval
## Vi delar in population i 5 stratum:
# Lågt andel
stratum1 = data[data$Andel_födda_på_population < 6,]
stratum1
# Liten lågt andel
stratum2 = data[data$Andel_födda_på_population >= 6 & data$Andel_födda_på_population < 8,]
stratum2
# Median andel
stratum3 = data[data$Andel_födda_på_population >= 8 & data$Andel_födda_på_population < 10,]
stratum3
# Liten högt andel
stratum4 = data[data$Andel_födda_på_population >= 10 & data$Andel_födda_på_population < 12,]
stratum4
# Högt andel
stratum5 = data[data$Andel_födda_på_population >= 12,]
stratum5

sd(stratum1$Population)
sd(stratum2$Population)
sd(stratum3$Population)
sd(stratum4$Population)
sd(stratum5$Population)
