### OSU urval
## Dra ett OSU på 30 kommuner från urvalsramen
sample_for_OSU_Urval <- sample(index(data),size=30,replace=FALSE)
OSU_Urval <- data[sample_for_OSU_Urval,]

OSU_Urval1 <- OSU_Urval[c("Kommunkod","Region","Population")]

OSU_Urval2 <- OSU_Urval[c("Kommunkod","Region","Andel_födda_på_population")]



