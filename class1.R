## Class 1, September 3th
## data base iris, funcion summarise de dplyr

library(dplyr)
data("iris")
View(iris)

## como crear un data frame

x <- c(1, 4, 6, 8, NA)
y <- c("a", "d", "f", "f", "f")
DF <- data.frame(numeros = x, letras=y)
DF

## trabajando con iris

summary <- summarise(iris, mean_petal_length = mean(Petal.Length) , 
                     SD_petal.length = sd(Petal.Length) )
View(summary)

## ahora, si a esto aplico group_by va a converteirse en un data frame agrupado que me
## va a sacar variables por los grupos, ejemplo:

summary1 <- group_by(iris, Species) 
summary2 <- summarise(summary1, mean_petal_length = mean(Petal.Length) , 
                     SD_petal.length = sd(Petal.Length) )
View(summary2)

## la funcion mutate crea variables nuevas

newvariable <- mutate(iris, Razon_petal_sepal = Petal.Length/Sepal.Width )
View(iris)

## filter y pipeline

DF2 <- DF %>% filter(!is.na(numeros))
DF2
DF3 <- DF %>% filter(numeros >4)
DF3

## data msleep, mamiferos y bedtime

library(ggplot2)
data("msleep")

Resumen <- msleep %>% 
  group_by(order) %>% 
  summarise(N = n()) %>%
  arrange(N) %>% 
  filter(N >= 5)

## select

Resumen <- iris %>% select(Species, starts_with("Petal"))
View(Resumen)

## ejercicio 1: Usando la base de datos storms del paquete dplyr, calcular la velocidad promedio 
## y diámetro promedio (hu_diameter) de las tormentas que han sido declaradas huracanes para cada año

data("storms")
names(storms)
View(storms)
Data1 <- storms %>% 
  select(year, status, wind, hu_diameter) %>%
  filter(status == "hurricane") %>% 
  group_by(year) %>% 
  summarise(windmean = mean(wind),
            diamprom = mean(hu_diameter, na.rm = T))
Data1  #Para ver rapidamente data1 en la consola 

## La base de datos mpg del paquete ggplot2 tiene datos de eficiencia vehicular en millas por galón 
## en ciudad (cty) en varios vehículos. Obtener los datos de vehículos del año 2004 en adelante que 
## sean compactos y transformar la eficiencia Km/litro (1 milla = 1.609 km; 1 galón = 3.78541 litros)

data(mpg)
View(mpg)
names(mpg)
Data2 <- mpg %>% 
  filter(year >= "2004", class == "compact") %>% 
  mutate(convert = cty*0.425053)
View(Data2)
