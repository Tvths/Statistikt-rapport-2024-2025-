library(palmerpenguins)
library(dplyr)
library(kableExtra)
library(ggplot2)
library(tibble)
library(cowplot)


### palmerpenguins data
penguins %>% 
  slice_head(n = 5) %>% 
  kable() %>% 
  kable_styling("striped")

h_penguins = head(penguins)



### histogram
ggplot(data = penguins) + aes(x = bill_length_mm) +
  geom_histogram(bins = 30, fill = "blue", color = "black") +
  theme_bw() + labs(x = "Näbblängd (mm)", y = "Antal") + ylim(0,40)


                                                             
modelData <- 
  penguins %>% 
  select(
    bill_length_mm,
    body_mass_g,
    flipper_length_mm,
    bill_depth_mm,
    species,
    sex
  )

### Anpassar angiven modell
simpleModel <- lm(formula = bill_length_mm ~., data = modelData)

summary(simpleModel)

### Skapa koefficient tabell
summary(simpleModel) %>% 
  coef() %>% 
  as_tibble(rownames = NA) %>% 
  rownames_to_column() %>% 
  rename(
    ` ` = rowname,
    Skattning = Estimate,
    Medelfel = `Std. Error`,
    `t-värde` = `t value`,
    `p-värde` = `Pr(>|t|)`
  ) %>% 
  kable(
    digits = 4,
    caption = "abc"
  ) %>% 
  kable_styling("striped")



X <- 
  model.matrix(
    bill_length_mm ~ ., 
    data = modelData
  )

### Visar de första fem raderna i matrisen
X[1:5,]














library(GGally)
library(xtable)
### Grupp data
data = read.csv("8_sales_data.csv")

### pairs diagram
p <- ggpairs(data ,
             columns = 1:5,
             title = "Samband mellan mått på blommor",
             upper = list(continuous = "points"),
             diag = list(continuous = "blankDiag"),
             lower = list(continuous = "blank"),
             axisLabels = "none")
p


### Diagram för grupp data
p1 <- ggplot(data) + aes(x = ad_budget, y = monthly_sales) + labs(x="Annonsbudget",y="Månadsförsäljning") +
  geom_point(color = "steelblue") + theme_bw() + stat_smooth(method = "lm",se = FALSE) + scale_x_continuous(breaks = c(0,10000,20000,30000))
p1
p2 <- ggplot(data) + aes(x=num_products,y=monthly_sales) + labs(x="Antal_produkt",y="Månadsförsäljning") +
  geom_point(color="steelblue") + theme_bw() + stat_smooth(method="lm", se=FALSE)
p2
p3 <- ggplot(data) + aes(x=store_size,y=monthly_sales) + labs(x="Butiks storlek",y="Månadsförsäljning") +
  geom_point(color="steelblue") + theme_bw() + stat_smooth(method = "lm",se = FALSE)
p3
p4 <- ggplot(data) + aes(x=days_open,y=monthly_sales) + labs(x="Antal öppetdagar",y="Månadsförsäljning") +
  geom_point(color="steelblue") + theme_bw() + stat_smooth(method = "lm",se=FALSE)
p4
p5 <- ggplot(data) + aes(x=store_type,y=monthly_sales) + labs(x="Butikstyp",y="Månadsförsäljning") +
  geom_violin(fill="steelblue") + theme_bw()
p5
p6 <- ggplot(data) + aes(x=region, y = monthly_sales) + labs(x="Region",y="Månadsförsäljning") +
  geom_violin(fill="steelblue") + theme_bw() 
p6

### Subplot för grupp data
plot_grid(p1, p2, p3, p4, p5, p6, labels = c('A', 'B', "C", "D", "E","F"), label_size = 12)

### Sum
new_data <- aggregate(monthly_sales ~ store_type,data = data, FUN = sum)
new_data <- aggregate(monthly_sales ~ region,data = data, FUN = mean)
print(which.min(data$days_open))

### fit object
lm_model1 = lm(monthly_sales ~ ad_budget + region,data)

### konfiden intervall
confint(lm_model1 )

### correlation mellan variabler 
cor.test(x = data$ad_budget, y = data$monthly_sales)

### fit object
lm_model = lm(data$ad_budget~data$monthly_sales,data)


coef(lm_model)

library(xtable)

### skapa tabell
Variabler = c("Monthly_sales","Ad_budget","Num_product","Store_size","Days_open","Store_type","Region")
Typ_Av_Variabler = c("Kontinuerligt kvantitativ","Kontinuerligt kvantitativ","Diskret kvantitativ","Kontinuerligt kvantitativ","Diskret kvantitativ","Kvalitativ","Kvalitativ")
Skala = c("kvotskala","kvotskala ","kvotskala","kvotskala","kvotskala","nominalskala","nominalskala")
data1 = data.frame(Variabler,Typ_Av_Variabler,Skala)
knitr::kable(data1,col.names = gsub("[.]", " ", names(data1)),caption = )

### data
modelData1 <- 
  data %>% 
  select(
    monthly_sales,
    ad_budget,
    store_size,
    store_type,
    region
  )

### fit object
simpleModel1 <- lm(formula = monthly_sales ~ ., data = modelData1)

### tabell
summary(simpleModel1)
summary(simpleModel1) %>% 
  coef() %>% 
  as_tibble(rownames = NA) %>% 
  rownames_to_column() %>% 
  rename(
    ` ` = rowname,
    Skattning = Estimate,
    Medelfel = `Std. Error`,
    `t-värde` = `t value`,
    `p-värde` = `Pr(>|t|)`
  ) %>% 
  kable(
    digits = 5
  ) %>% 
  kable_styling("striped")


b <- xtable(simpleModel1, caption="Lite regressioner.")
tableData <- head(b[,c("column1",
                                    "column2",
                                    "column3")])
xt <- xtable(b)
print(xt,type="html")



X <- 
  model.matrix(
    monthly_sales ~ ., 
    data = data
  )

# Visar de första fem raderna i matrisen
X[1:5,]


Y <- 
  data$monthly_sales %>% 
  as.matrix()

# Visar de första fem raderna i vektorn
Y[1:5,]




##intervall

y = data$monthly_sales
y*y
sum(y)
sum(y*y)
lm_model1 = lm(monthly_sales ~ ad_budget + region,data)
confint(lm_model1,level=0.95 )


### fit object
lm_model2 = lm(monthly_sales ~ ad_budget + store_size,data)

### anova
anovaTable <- anova(lm_model2)

# Beräknar raden för SSR utifrån alla rader förutom SSE
SSR <- anovaTable[-nrow(anovaTable),] %>% 
  summarize(across(Df:`Sum Sq`, ~sum(.x))) %>% 
  mutate(`Mean Sq` = `Sum Sq` / Df,
         `F value` = NA,
         `Pr(>F)` = NA)

# Kombinerar SSR med SSE från ursprungliga tabellen
simpleAnova <- SSR %>% 
  add_row(anovaTable[nrow(anovaTable),]) %>% 
  mutate(
    `F value` = 
      ifelse(row_number() == 1,
             `Mean Sq`[1] / `Mean Sq`[2], 
             NA),
    `Pr(>F)` = 
      ifelse(row_number() == 1, 
             pf(q = `F value`[1], df1 = Df[1], df2 = Df[2], lower.tail = FALSE), 
             NA)
  )
rownames(simpleAnova) <- c("Model", "Residuals")

kable(simpleAnova, digits = 4) %>% 
  kable_styling("striped")





### residual

modelData <- 
  data %>% 
  select(
    monthly_sales,
    ad_budget,
    store_size,
    store_type,
    region
  )

simpleModel1 <- lm(formula = monthly_sales ~ ., data = modelData)
par(mfrow = c(2, 2))
plot(simpleModel1)

residualData <- 
  tibble(
    residuals = residuals(simpleModel1),
    y = modelData1$monthly_sales,
    yHat = fitted(simpleModel1)
  )
p1 <- ggplot(residualData) + 
  aes(x = residuals, y = after_stat(ndensity)) +
  geom_histogram( fill = "steelblue", color = "black") + 
  theme_bw() + 
  labs(x = "Residualer", y = "Densitet")
p1
p3 <- ggplot(residualData) + 
  aes(sample = scale(residuals)) + 
  geom_qq_line() +
  geom_qq(color = "steelblue") +
  theme_bw() + 
  labs(x = "Teoretiska kvantiler", y = "Observerade kvantiler")
p3

### p värde
p_varde = 1 -pf(113,3,df1=2,df2=125)
p_varde




### anpassa diagram (lika varians)
ggplot(residualData) + 
  aes(x = yHat, y = residuals) + 
  geom_point(color = "steelblue") + 
  theme_bw() +
  labs(x = "Anpassade värden", y = "Residualer") + 
  geom_hline(
    aes(yintercept = 0)
  ) + 
  # Imaginära gränser
  geom_hline(
    aes(yintercept = -30000),
    color = "#d9230f",
    linetype = 2
  ) + 
  geom_hline(
    aes(yintercept = 30000),
    color = "#d9230f",
    linetype = 2
  )


### oberoende
ggplot(residualData) + 
  aes(x = 1:nrow(residualData), y = residuals) + 
  geom_line(color = "steelblue") + 
  theme_bw() +
  labs(x = "Obs. index", y = "Residualer") + 
  geom_hline(
    aes(yintercept = 0),
    color = "black"
  )



### Skapa subplot för residualer
residualPlots <- function(model) {
  residualData <- 
    data.frame(
      residuals = residuals(model),
      # Responsvariabeln finns som första kolumn i modellens model-objekt
      y = model$model[,1],
      yHat = fitted(model)
    )
  
  
  p1 <- ggplot(residualData) + 
    aes(x = residuals, y = after_stat(density)) +
    geom_histogram( fill = "steelblue", color = "black") + 
    theme_bw() + 
    labs(x = "Residualer", y = "Densitet")
  
  p2 <- ggplot(residualData) + 
    aes(x = yHat, y = residuals) + 
    geom_hline(aes(yintercept = 0)) + 
    geom_point(color = "steelblue") + 
    theme_bw() +
    labs(x = "Anpassade värden", y = "Residualer") +
    geom_hline(
      aes(yintercept = -30000),
      color = "#d9230f",
      linetype = 2) + 
    geom_hline(
      aes(yintercept = 30000),
      color = "#d9230f",
      linetype = 2
    )
  
  p3 <- ggplot(residualData) + 
    # Använder standardiserade residualer
    aes(sample = scale(residuals)) + 
    geom_qq_line() + 
    geom_qq(color = "steelblue") +
    theme_bw() + 
    labs(x= "Teoretiska kvantiler", y = "Observerade kvantiler")
  p4 <- ggplot(residualData) + 
    aes(x = 1:nrow(residualData), y = residuals) + 
    geom_line(color = "steelblue") + 
    theme_bw() +
    labs(x = "Obs. index", y = "Residualer") + 
    geom_hline(
      aes(yintercept = 0),
      color = "black"
    )
  
  cowplot::plot_grid(p1, p2, p3,p4, nrow = 2)
  
}
residualPlots(simpleModel1)

