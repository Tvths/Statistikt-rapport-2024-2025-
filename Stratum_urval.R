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

## Standard deviation for every group
s2_1 = var(stratum1$Population)
s2_2 = var(stratum2$Population)
s2_3 = var(stratum3$Population)
s2_4 = var(stratum4$Population)
s2_5 = var(stratum5$Population)

## The number of every group
N1 = length(stratum1$Population)
N2 = length(stratum2$Population)
N3 = length(stratum3$Population)
N4 = length(stratum4$Population)
N5 = length(stratum5$Population)

## 
NX1_bar = N1*mean(stratum1$Population)
NX2_bar = N2*mean(stratum2$Population)
NX3_bar = N3*mean(stratum3$Population)
NX4_bar = N4*mean(stratum4$Population)
NX5_bar = N5*mean(stratum5$Population)

##
NX_bar_stratifierat = 16/290*NX1_bar + 95/290*NX2_bar + 147/290*NX3_bar + 28/290*NX4_bar + 4/290*NX5_bar

## Sample of every group
n1 = 5
n2 = 33
n3 = 51
n4 = 10
n5 = 1

## Total municipality
N = 290
## 
V_hat_stratifierat = (N1^2/N)^2*(s2_1/n1)*((N1-n1)/(N1-1)) + (N2^2/N)^2*(s2_2/n2)*((N2-n2)/(N2-1)) + 
  (N3^2/N)^2*(s2_3/n3)*((N3-n3)/(N3-1)) + (N4^2/N)^2*(s2_4/n4)*((N4-n4)/(N4-1)) + (N5^2/N)^2*(s2_5/n5)*((N5-n5)/(N5-1))

## Standar error
se_stratifierat = 1.96 * sqrt(V_hat_stratifierat)

## Interval
LCL_stratifierat = NX_bar_stratifierat - se_stratifierat
UCL_stratifierat = NX_bar_stratifierat + se_stratifierat
