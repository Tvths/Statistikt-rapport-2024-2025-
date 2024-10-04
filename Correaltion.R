korrelation1 = cor(stratum1$Andel_födda_på_population,stratum1$Population)
korrelation1
korrelation2 = cor(stratum2$Andel_födda_på_population,stratum2$Population)
korrelation2
korrelation3 = cor(stratum3$Andel_födda_på_population,stratum3$Population)
korrelation3
korrelation4 = cor(stratum4$Andel_födda_på_population,stratum4$Population)
korrelation4
korrelation5 = cor(stratum5$Andel_födda_på_population,stratum5$Population)
korrelation5



### bredd intervall är 1000000
V_XBar = (500000/1.96)^2 

n = (N1*s2_1 + N2*s2_2 + N3*s2_3 + N4*s2_4 + N5*s2_5)/(V_XBar + (1/N)*(N1*s2_1 + N2*s2_2 + N3*s2_3 + N4*s2_4 + N5*s2_5))
n 