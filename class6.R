## Clase 6
install.packages("lubridate")

## for loop: forma mas facil de hacer un loop 

library(tidyverse)

for ( k in 1:10) {
  print(k +5)
}

## purrr: funciona con tidyverse, por lo que puedo usar pipeline. primero menciono al vector o la lista con la que voy a 
## trabajar, y luego digo que a ese valor ( ~ ) de la lista le aplico la funcion .f despues de la virgulilla. 

1:10 %>% map(~ print(.x +5))

stations <- read_csv("Madrid/stations.csv")
M17 <- read_csv("Madrid/madrid_2017.csv")

## para sacar el año o mes si esta en formato, ocupo lubridate
library("lubridate")

M17b <-M17 %>% filter(station %in% c(28079038, 28079058, 28079008, 28079036, 28079060)) %>% 
  mutate(month = month(date), 
         year = year(date)) %>% 
  group_by(year, month, station) %>% 
  summarize(no2 = mean(NO_2, na.rm = T), n = n()) %>%
  filter(n > 10)

## si yo quiero esto con todas las tablas ... podria hacer un loop !
## con list.files y full.names puedo rescatar todos los directorios
todas_tablas <- list.files("Madrid", full.names = TRUE, pattern = ".csv")
todas_tablas

## loop 

"Madrid/madrid_2017.csv" %>% 
  read_csv() %>% 
  filter(station %in% c(28079038, 28079058, 28079008, 28079036, 28079060)) %>% 
  mutate(month = month(date), 
         year = year(date)) %>% 
  group_by(year, month, station) %>% 
  summarize(no2 = mean(NO_2, na.rm = T), n = n()) %>%
  filter(n > 10)
  
# tengo que poner el .x que es donde entra mi argumento, que seria en read.

resultado <- todas_tablas %>% 
  map( ~ read_csv(.x) %>% 
         filter(station %in% c(28079038, 28079058, 28079008, 28079036, 28079060)) %>% 
         mutate(month = month(date), 
                year = year(date)) %>% 
         group_by(year, month, station) %>% 
         summarize(no2 = mean(NO_2, na.rm = T), n = n()) %>%
         filter(n > 10)) %>% 
  reduce(rbind)
  
# con for se hace: primero hay que crear un objeto donde se me guardaran los resultados, que es una lista vacia
lista_tablas <- list()

for (i in todas_tablas[1:2]) {
  lista_tablas[[length(lista_tablas)+1]] <- 
    read_csv(i) %>% 
    filter(station %in% c(28079038, 28079058, 28079008, 28079036, 28079060)) %>% 
    mutate(month = month(date), 
           year = year(date)) %>% 
    group_by(year, month, station) %>% 
    summarize(no2 = mean(NO_2, na.rm = T), n = n()) %>%
    filter(n > 10)
}
lista_tablas <- lista_tablas %>% reduce(rbind)

# OBTENGO 18 TABLAS PARA HACER EL PLOT 
install.packages("ImageMagic")
