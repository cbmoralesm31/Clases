## Class 3 September 9th
## Tidyverse and Tidyr
## There's only two functions for today, but really complex. ** gaather** an **spread**  make tables vertical
## and horizontal, respectively. **gather** takes every column and put it in order, key recognize the headline
## and value= recognize the rest of the rows. If one column is already a tidy form, we can put less (-) as the
## final argument, in front of the name of the original column.

library(dismo)
Huemul <- gbif("Hippocamelus", "bisulcus", down = TRUE)
view(Huemul)
names(Huemul)
# useful columns: acceptedScientificName, basisOfRecord, lon, lat

Huemules <- Huemul %>% dplyr::select(basisOfRecord, lon, lat) %>% 
  group_by(basisOfRecord) %>%  filter(!is.na(lon) & !is.na(lat)) %>% summarise(n= n())
View(Huemules)


## exercise 2, fucking ine
library(readxl)
nombre_localidades <- read_excel("C:/Users/Lenovo/Downloads/dimension-aire-factor-estado-excel.xlsx", 
                                 sheet = "T002")

temperatura_media <- read_excel("C:/Users/Lenovo/Downloads/dimension-aire-factor-estado-excel.xlsx", 
                                sheet = "E10000003")

humedad <- read_excel("C:/Users/Lenovo/Downloads/dimension-aire-factor-estado-excel.xlsx", 
                      sheet = "E10000006")

mp250 <- read_excel("C:/Users/Lenovo/Downloads/dimension-aire-factor-estado-excel.xlsx", 
                                                 sheet = "E10000011")
# mp250 esta en microgramos por metro cubico 

## variables limpias
names(temperatura_media)
names(humedad)
names(mp250)
names(nombre_localidades)

## seleccionar las columnas que corresponden, ademas cambiar el nombre columna valueF a la medida correcta
## y ademas cambiar el nombre de la columna que conflictua del nombre de las estaciones
tmedia <- temperatura_media %>% dplyr::select(Mes, Año, Est_Meteoro, ValorF) %>% rename(Temp_C = ValorF, Codigo_Est_Monitoreo = Est_Meteoro )
hum <- humedad %>% dplyr::select(Mes, Año, Est_Meteoro, ValorF) %>% rename( Porc_Hum = ValorF, Codigo_Est_Monitoreo = Est_Meteoro)
mp25 <- mp250 %>% dplyr::select(Mes, Año, Est_Monitoreo, ValorF) %>% rename( MicrogM3 = ValorF, Codigo_Est_Monitoreo = Est_Monitoreo)


## Ahora deberia unir todo 
temploc <- left_join(tmedia, nombre_localidades)
view(temploc)
humloc <- left_join(hum, nombre_localidades)
view(humloc)
mp25loc <- left_join(mp25, nombre_localidades)
view(mp25loc)

## se debe cambiar el original de la planilla de localidades
