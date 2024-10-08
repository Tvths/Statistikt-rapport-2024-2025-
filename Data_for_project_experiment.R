### Step 1: Library required
library(tidyverse) 
library(pxweb) 
library(stringr)
library(dplyr)
library(zoo)


### Step 2: extract data from database PXWEB
# only hold 4 digits
region <- c("00","01","0114","0115","0117","0120","0123","0125","0126","0127","0128","0136","0138","0139","0140","0160","0162","0163","0180","0181","0182","0183","0184","0186","0187","0188","0191","0192","03","0305","0319","0330","0331","0360","0380","0381","0382","04","0428","0461","0480","0481","0482","0483","0484","0486","0488","05","0509","0512","0513","0560","0561","0562","0563","0580","0581","0582","0583","0584","0586","06","0604","0617","0642","0643","0662","0665","0680","0682","0683","0684","0685","0686","0687","07","0760","0761","0763","0764","0765","0767","0780","0781","08","0821","0834","0840","0860","0861","0862","0880","0881","0882","0883","0884","0885","09","0980","10","1060","1080","1081","1082","1083","12","1214","1230","1231","1233","1256","1257","1260","1261","1262","1263","1264","1265","1266","1267","1270","1272","1273","1275","1276","1277","1278","1280","1281","1282","1283","1284","1285","1286","1287","1290","1291","1292","1293","13","1315","1380","1381","1382","1383","1384","14","1401","1402","1407","1415","1419","1421","1427","1430","1435","1438","1439","1440","1441","1442","1443","1444","1445","1446","1447","1452","1460","1461","1462","1463","1465","1466","1470","1471","1472","1473","1480","1481","1482","1484","1485","1486","1487","1488","1489","1490","1491","1492","1493","1494","1495","1496","1497","1498","1499","17","1715","1730","1737","1760","1761","1762","1763","1764","1765","1766","1780","1781","1782","1783","1784","1785","18","1814","1860","1861","1862","1863","1864","1880","1881","1882","1883","1884","1885","19","1904","1907","1960","1961","1962","1980","1981","1982","1983","1984","20","2021","2023","2026","2029","2031","2034","2039","2061","2062","2080","2081","2082","2083","2084","2085","21","2101","2104","2121","2132","2161","2180","2181","2182","2183","2184","22","2260","2262","2280","2281","2282","2283","2284","23","2303","2305","2309","2313","2321","2326","2361","2380","24","2401","2403","2404","2409","2417","2418","2421","2422","2425","2460","2462","2463","2480","2481","2482","25","2505","2506","2510","2513","2514","2518","2521","2523","2560","2580","2581","2582","2583","2584")  
kommun <- region %>% str_extract_all(pattern = "\\d{4}+") %>% unlist()

## This data describe about average age of population by region in 2023
#PXWEB query 
pxweb_query_list1 <-  
  list("Region"= kommun, 
       "Kon"=c("1+2"), 
       "ContentsCode"=c("BE0101G9"), 
       "Tid"=c("2023")) 
# Download data 
px_data1 <- pxweb_get(url = "https://api.scb.se/OV0104/v1/doris/sv/ssd/BE/BE0101/BE0101B/BefolkningMedelAlder", 
                      query = pxweb_query_list1)
# Convert to data.frame 
medelålder_kommun <- as.data.frame(px_data1, column.name.type = "text", variable.value.type = "text") 




## This data describe the amount of birth in Sweden in 2023
# PXWEB query 
pxweb_query_list <- 
  list("Region"= kommun,
       "AlderModer"=c("tot"),
       "Kon"=c("1","2"),
       "ContentsCode"=c("BE0101E2"),
       "Tid"=c("2023"))

# Download data 
px_data <- 
  pxweb_get(url = "https://api.scb.se/OV0104/v1/doris/sv/ssd/BE/BE0101/BE0101H/FoddaK",
            query = pxweb_query_list)

# Convert to data.frame 
px_data_frame <- as.data.frame(px_data, column.name.type = "text", variable.value.type = "text")

# Get pxweb data comments 
px_data_comments <- pxweb_data_comments(px_data)
px_data_comments_df <- as.data.frame(px_data_comments)

# Cite the data as 
pxweb_cite(px_data)

total_fodda <- aggregate(x = `Levande födda` ~ region, data = px_data_frame, FUN = sum) 
# Convert the region to a factor with levels in the correct order 
total_fodda$region <- factor(total_fodda$region, levels = unique(medelålder_kommun$region)) 
# Sort by the 'region' factor levels 
total_fodda <- total_fodda[order(total_fodda$region),]



## This data describe the population by region in sweden in 2023
# PXWEB query 
pxweb_query_list <- 
  list("Region"=c("0114","0115","0117","0120","0123","0125","0126","0127","0128","0136","0138","0139","0140","0160","0162","0163","0180","0181","0182","0183","0184","0186","0187","0188","0191","0192","0305","0319","0330","0331","0360","0380","0381","0382","0428","0461","0480","0481","0482","0483","0484","0486","0488","0509","0512","0513","0560","0561","0562","0563","0580","0581","0582","0583","0584","0586","0604","0617","0642","0643","0662","0665","0680","0682","0683","0684","0685","0686","0687","0760","0761","0763","0764","0765","0767","0780","0781","0821","0834","0840","0860","0861","0862","0880","0881","0882","0883","0884","0885","0980","1060","1080","1081","1082","1083","1214","1230","1231","1233","1256","1257","1260","1261","1262","1263","1264","1265","1266","1267","1270","1272","1273","1275","1276","1277","1278","1280","1281","1282","1283","1284","1285","1286","1287","1290","1291","1292","1293","1315","1380","1381","1382","1383","1384","1401","1402","1407","1415","1419","1421","1427","1430","1435","1438","1439","1440","1441","1442","1443","1444","1445","1446","1447","1452","1460","1461","1462","1463","1465","1466","1470","1471","1472","1473","1480","1481","1482","1484","1485","1486","1487","1488","1489","1490","1491","1492","1493","1494","1495","1496","1497","1498","1499","1715","1730","1737","1760","1761","1762","1763","1764","1765","1766","1780","1781","1782","1783","1784","1785","1814","1860","1861","1862","1863","1864","1880","1881","1882","1883","1884","1885","1904","1907","1960","1961","1962","1980","1981","1982","1983","1984","2021","2023","2026","2029","2031","2034","2039","2061","2062","2080","2081","2082","2083","2084","2085","2101","2104","2121","2132","2161","2180","2181","2182","2183","2184","2260","2262","2280","2281","2282","2283","2284","2303","2305","2309","2313","2321","2326","2361","2380","2401","2403","2404","2409","2417","2418","2421","2422","2425","2460","2462","2463","2480","2481","2482","2505","2506","2510","2513","2514","2518","2521","2523","2560","2580","2581","2582","2583","2584"),
       "Civilstand"=c("OG","G","SK","ÄNKL"),
       "Alder"=c("tot"),
       "Kon"=c("1","2"),
       "ContentsCode"=c("BE0101N1"),
       "Tid"=c("2023"))

# Download data 
px_data <- 
  pxweb_get(url = "https://api.scb.se/OV0104/v1/doris/sv/ssd/BE/BE0101/BE0101A/BefolkningNy",
            query = pxweb_query_list)

# Convert to data.frame 
befolkning_komun <- as.data.frame(px_data, column.name.type = "text", variable.value.type = "text")
colnames(befolkning_komun)[6] <- "population"
# Get pxweb data comments 
px_data_comments <- pxweb_data_comments(px_data)
px_data_comments_df <- as.data.frame(px_data_comments)

#
befolkning_komun <- aggregate(population ~ region, data = befolkning_komun, FUN = sum)
# Convert the region to a factor with levels in the correct order 
befolkning_komun$region <- factor(befolkning_komun$region, levels = unique(medelålder_kommun$region)) 
# Sort by the 'region' factor levels 
befolkning_komun <- befolkning_komun[order(befolkning_komun$region),]

# round(digit=2)
total_fodda$`Levande födda` = round((total_fodda$`Levande födda`/befolkning_komun$population)*1000,2)




### Step 3: Synthesize the necessary data to project
# add amount of death to dataframe average age of population
data <- cbind(befolkning_komun,total_fodda$`Levande födda`)

# Add kommunkod column to dataframe 
data <- cbind(kommun,data)
# Modify names of column
colnames(data)= c("Kommunkod","Region","Population","Andel_födda_på_population")



