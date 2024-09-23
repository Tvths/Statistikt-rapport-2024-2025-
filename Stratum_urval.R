
### stratifierat urval
## Vi delar in population i 5 stratum:
# Lågt antalet döđfall
stratum1 = data[data$Dödfall < 200,]
stratum1
# Liten lågt antalet dödfall
stratum2 = data[data$Dödfall >= 200 & data$Dödfall < 500,]
stratum2
# Median antalet dödfall
stratum3 = data[data$Dödfall >= 500 & data$Dödfall < 1000,]
stratum3
# Liten högt antalet dödfall
stratum4 = data[data$Dödfall >= 1000 & data$Dödfall < 3000,]
stratum4
# Högt antalet dödfall
stratum5 = data[data$Dödfall >= 3000,]
stratum5


var(stratum1$Medelålder)
var(stratum2$Medelålder)
var(stratum3$Medelålder)
var(stratum4$Medelålder)
var(stratum5$Medelålder)
