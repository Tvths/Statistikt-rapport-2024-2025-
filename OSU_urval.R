### OSU urval
## Dra ett OSU på 30 kommuner från urvalsramen
set.seed(123)
sample_for_OSU_Urval <- sample(index(data),size=30,replace=FALSE)
OSU_Urval <- data[sample_for_OSU_Urval,]

OSU_Urval1 <- OSU_Urval[c("Kommunkod","Region","Population")]

OSU_Urval2 <- OSU_Urval[c("Kommunkod","Region","Andel_födda_på_population")]


## 
NX_bar_OSU = 290 * mean(OSU_Urval$Population)

##
V_hat_OSU = 290^2 * (var(OSU_Urval$Population)/30) * ((290-30)/(290-1))

## Standar error
se_OSU = 1.96 * sqrt(V_hat_OSU)

## interval
LCL_OSU = NX_bar_OSU - se_OSU
UCL_OSU = NX_bar_OSU + se_OSU
