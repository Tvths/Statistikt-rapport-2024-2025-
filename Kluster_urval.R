kluster1 <- data[index(data$Region) <= 10,]
kluster2 <- data[index(data$Region) > 10 & index(data$Region) <= 20,]
kluster3 <- data[index(data$Region) > 20 & index(data$Region) <= 30,]
kluster4 <- data[index(data$Region) > 30 & index(data$Region) <= 40,]
kluster5 <- data[index(data$Region) > 40 & index(data$Region) <= 50,]
kluster6 <- data[index(data$Region) > 50 & index(data$Region) <= 60,]
kluster7 <- data[index(data$Region) > 60 & index(data$Region) <= 70,]
kluster8 <- data[index(data$Region) > 70 & index(data$Region) <= 80,]
kluster9 <- data[index(data$Region) > 80 & index(data$Region) <= 90,]
kluster10 <- data[index(data$Region) > 90 & index(data$Region) <= 100,]
kluster11 <- data[index(data$Region) > 100 & index(data$Region) <= 110,]
kluster12 <- data[index(data$Region) > 110 & index(data$Region) <= 120,]
kluster13 <- data[index(data$Region) > 120 & index(data$Region) <= 130,]
kluster14 <- data[index(data$Region) > 130 & index(data$Region) <= 140,]
kluster15 <- data[index(data$Region) > 140 & index(data$Region) <= 150,]
kluster16 <- data[index(data$Region) > 150 & index(data$Region) <= 160,]
kluster17 <- data[index(data$Region) > 160 & index(data$Region) <= 170,]
kluster18 <- data[index(data$Region) > 170 & index(data$Region) <= 180,]
kluster19 <- data[index(data$Region) > 180 & index(data$Region) <= 190,]
kluster20 <- data[index(data$Region) > 190 & index(data$Region) <= 200,]
kluster21 <- data[index(data$Region) > 200 & index(data$Region) <= 209,]
kluster22 <- data[index(data$Region) > 209 & index(data$Region) <= 218,]
kluster23 <- data[index(data$Region) > 218 & index(data$Region) <= 227,]
kluster24 <- data[index(data$Region) > 227 & index(data$Region) <= 236,]
kluster25 <- data[index(data$Region) > 236 & index(data$Region) <= 245,]
kluster26 <- data[index(data$Region) > 245 & index(data$Region) <= 254,]
kluster27 <- data[index(data$Region) > 254 & index(data$Region) <= 263,]
kluster28 <- data[index(data$Region) > 263 & index(data$Region) <= 272,]
kluster29 <- data[index(data$Region) > 272 & index(data$Region) <= 281,]
kluster30 <- data[index(data$Region) > 281 & index(data$Region) <= 290,]


list <- list(kluster1, kluster2, kluster3, kluster4, kluster5, kluster6,
             kluster7, kluster8, kluster9, kluster10, kluster11, kluster12,
             kluster13, kluster14, kluster15, kluster16, kluster17, kluster18,
             kluster19, kluster20, kluster21, kluster22, kluster23, kluster24,
             kluster25, kluster26, kluster27, kluster28, kluster29, kluster30)

set.seed(123)
sample(index(list),10,replace=FALSE)


## the number of every sample cluster and mean of them
n1=n2=n7=n10 = 9
n3=n4=n5=n6=n8=n9 = 10
n_bar = (9*4 + 10*6)/10

## Mean of every sample cluster 
X1_bark = mean(kluster25$Population)
X2_bark = mean(kluster29$Population)
X3_bark = mean(kluster16$Population)
X4_bark = mean(kluster4$Population)
X5_bark = mean(kluster18$Population)
X6_bark = mean(kluster15$Population)
X7_bark = mean(kluster22$Population)
X8_bark = mean(kluster9$Population)
X9_bark = mean(kluster6$Population)
X10_bark = mean(kluster30$Population)

## 
X_bark = (9*X1_bark + 9*X2_bark + 10*X3_bark + 10*X4_bark + 10*X5_bark + 10*X6_bark + 9*X7_bark + 10*X8_bark + 10*X9_bark + 9*X10_bark)/(9*4 + 10*6)

##
V_hatk = (20/(300*n_bar^2))*(((9^2*(X1_bark - X_bark))/9) + ((9^2*(X2_bark - X_bark))/9) + ((10^2*(X3_bark - X_bark))/9) + ((10^2*(X4_bark - X_bark))/9) + ((10^2*(X5_bark - X_bark))/9) + ((10^2*(X6_bark - X_bark))/9) + ((9^2*(X7_bark - X_bark))/9) + ((10^2*(X8_bark - X_bark))/9) + ((10^2*(X9_bark - X_bark))/9) + ((9^2*(X10_bark - X_bark))/9)) 

## Standar error
se_kluster = 1.96*sqrt(V_hatk)

## Interval
LCL_kluster = X_bark - se_kluster
UCL_kluster = X_bark + se_kluster
