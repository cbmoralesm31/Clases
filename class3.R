## Class 3 September 9th
## Tidyverse and Tidyr
## There's only two functions for today, but really complex. ** gather** an **spread**, it makes tables vertical
## and horizontal, respectively. **gather** takes every column and put it in order, "key" recognize the headline
## and value= recognize the rest of the rows. If one column is already a tidy form, we can put less (-) as the
## final argument, in front of the name of the original column.

library(dismo)
library(plyr)
library(tidyverse)
library(knitr)
library(readxl)

## we are goint to use dismo and download data fron gbif. 

Huemul <- gbif("Hippocamelus", "bisulcus", down = TRUE)
view(Huemul)
names(Huemul)

## exercise 1: Tomando la base de datos generada en gbif, quedarse con solo las observaciones que tienen 
## coordenadas geograficas y determinar cuantas observaciones son de observacion humana y cuantas de 
## especimen de museo. 

## useful columns: acceptedScientificName, basisOfRecord, lon, lat
## :: porque hay mas de un paquete que tiene la funcion select y genera un error. los dos puntos indican 
## de que paquete viene la funcion

Huemules <- Huemul %>% 
  dplyr::select(basisOfRecord, lon, lat) %>%                      
  group_by(basisOfRecord) %>%  
  filter(!is.na(lon) & !is.na(lat)) %>% 
  summarise(n= n())

View(Huemules)

## exercise 2, fucking ine: 
# Entrar a INE ambiental y bajar la base de datos de Dimensión Aire.
# Generar una base de datos tidy con las siguientes 5 columnas
# 1. El nombre de la localidad donde se encuntra la estación
# 2. El año en que se tomo la medida
# 3. El mes en que se tomo la medida
# 4. La temperatura media de ese mes
# 5. La media del mp25 de ese mes
# 6. Humedad relativa media mensual
# De la base de datos anterior obterner un segundo data frame en la cual calculen para cada variable 
# y estación la media y desviación estandar para cada mes

## primero, subir los datos de las hojas seleccionadas

nombre_localidades <- read_excel("dimension-aire-factor-estado-excel.xlsx", 
                                                 sheet = "T001")

temperatura_media <- read_excel("C:/Users/Lenovo/Downloads/dimension-aire-factor-estado-excel.xlsx", 
                                sheet = "E10000003")

humedad <- read_excel("C:/Users/Lenovo/Downloads/dimension-aire-factor-estado-excel.xlsx", 
                      sheet = "E10000006")

mp250 <- read_excel("C:/Users/Lenovo/Downloads/dimension-aire-factor-estado-excel.xlsx", 
                                                 sheet = "E10000011")

## segundo, limpiar las tablas respecto a las columnas que me interesan

names(temperatura_media)
names(humedad)
names(mp250)
names(nombre_localidades)

## -> seleccionar las columnas que corresponden, ademas cambiar el nombre columna valueF a la medida correcta
## y ademas cambiar el nombre de la columna que conflictua del nombre de las estaciones

nombre_loc <- nombre_localidades %>% dplyr::select(Codigo_Est_Meteoro, Ciudad_localidad) %>% rename(Codigo_Est_Monitoreo = Codigo_Est_Meteoro)
tmedia <- temperatura_media %>% dplyr::select(Mes, Año, Est_Meteoro, ValorF) %>% rename(Temp_C = ValorF, Codigo_Est_Monitoreo = Est_Meteoro)
hum <- humedad %>% dplyr::select(Mes, Año, Est_Meteoro, ValorF) %>% rename( Porc_Hum = ValorF, Codigo_Est_Monitoreo = Est_Meteoro)
mp25 <- mp250 %>% dplyr::select(Mes, Año, Est_Monitoreo, ValorF) %>% rename( MicrogM3 = ValorF, Codigo_Est_Monitoreo = Est_Monitoreo)

## Ahora deberia unir todo. p1 las tres variables, p2 renombrar localidades eliminando codigo 

th <- left_join(tmedia, hum)
view(th)
thm <- left_join(th, mp25)
view(thm)

table1 <- left_join(thm, nombre_loc)
view(table1)
table1 <- table1 %>% dplyr::select(- Codigo_Est_Monitoreo)
