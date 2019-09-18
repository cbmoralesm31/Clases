library(tidyverse)
library(ggplot2)
library(knitr)

# CARGAR DATOS UFO
ufo_sightings <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-25/ufo_sightings.csv")
str(ufo_sightings)
data1 <- ufo_sightings %>% filter(!is.na(country)) %>%  group_by(country) %>% summarise( n = n())
data1
ufo <- ufo_sightings %>% mutate(minutos = (encounter_length/60)) %>% filter(!is.na(country), !is.na(minutos))
view(ufo)
str(ufo)
# GRAFICOS PRELIMINARES

barplot <- ggplot(data = data1, aes(country, n, fill= country)) + 
  geom_bar(stat = "identity") +
  labs(fill = "Pais", x= "Pais", y= "Numero de observaciones") +
  scale_fill_discrete(name = "Pais", labels = c("A", "C", "D", "U", "US"))
barplot

## TIEMPO DE ENCUENTRO POR PAIS: grafico debe ser mejorado ya que tiene datos de distribucion rata
## ver formas de estudiar la distribucion de los datos 

ggplot(data = ufo, aes(country, minutos, fill= country)) + 
  geom_violin(fill= "orchid3", col= "magenta") +
  theme_classic()

## 
