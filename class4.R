library(ggplot2)
library(tidyverse)
data(mtcars)
view(mtcars)

## grafico en ggplot2, utilizando los datos de autos
## fc: aestetics, aspectos esteticos... ahi defino la x y la y de lo que quiero representar

ggplot(mtcars, aes(x= wt, y= mpg)) +
  geom_point()+
  theme_grey()

ggplot(mtcars, aes(x= wt, y= mpg)) +
  geom_point(col= "blue")+
  theme_dark()

data("ChickWeight")
ggplot(ChickWeight, aes(x= Time, y= weight))+
  geom_point()

## en el grafico que se genera no se distingue el efecto de la dieta uno o dos (una de las variables) 
## entonces con la funcion aes que hace referencia a mis datos le puedo pedir que diferencie entre dietas

data("ChickWeight")
ggplot(ChickWeight, aes(x= Time, y= weight))+
  geom_point(aes(col= Diet))

## otra cosa importante es que aes reconoce de manera inmediata que el primero se asigna a x y el segundo
## a y. 

data("diamonds")
ggplot(diamonds, aes(carat, price))+
  geom_point(size= 0.5,
             alpha= 0.3)

## puedo combinar color y alpha para destacar mejor mis datos: separo por color a los diferentes variables
## y ademas le doy un indice de transparencia para destacar lo que a mi me interesa

ggplot(diamonds, aes(carat, price))+
  geom_point(aes(col= cut, alpha= cut), 
             size= 0.5)

## modificacion de puntos
          
ggplot(ChickWeight, aes(Time, weight)) +
  geom_point(shape=21, fill= "blue",
             col= "red", alpha = 0.5)

## boxplot
data("iris")
ggplot(iris, aes(Species, Petal.Length)) +
  geom_boxplot(fill= "#ff3333", col= "dark grey") +
  theme_classic()

## grafico violin, muestra la frecuencia de mis datos interpretado como un histograma. Dato que la anchura 
## del grafico muestra cuantos datos tienen el mismo valor. Para eso ayuda la funcion coord_flip para dar 
## vuelta los ejes
ggplot(iris, aes(Species, Petal.Length)) +
  geom_violin(fill= "#ff3333", col= "dark red") +
  theme_classic() +
  coord_flip()

ggplot(iris, aes(Species, Petal.Length)) +
  geom_violin(fill= "#ff3333", col= "dark red") +
  theme_classic()

ggplot(iris, aes(Species, Petal.Length)) +
  geom_violin(fill= "#ff3333", col= "dark red", alpha=0.1) +
  geom_jitter(col= "#ff3333")+
  theme_classic()
  
## si quiero hacer una seleccion exclusiva debo llamar nuevamente los datos
# ggplot(iris, aes(Species, Petal.Length)) +
#   geom_violin(data= iris %>% 
#                 filter(Species== "versicolor"), 
#               aes( Species, Petal.Length),
#               alpha= 1, fill= "red"
#               
              
## hexagono
ggplot(diamonds, aes(carat, price))+
  geom_hex()


## lineas de tendencia. Geomsmooth agrega la linea, la sombra es automaticamente la desviacion standard.
ggplot(ChickWeight, aes(Time, weight)) +
  geom_point()+
  geom_smooth()

ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  geom_smooth(method = "lm")

ggplot(ChickWeight, aes(Time, weight)) +
  geom_point(aes(col= Diet)) +
  geom_smooth(method= "lm", aes(col= Diet))


ggplot(ChickWeight, aes(Time, weight, col= Diet)) +
  geom_point() +
  geom_smooth(method= "lm")

## stat_smooth: te permite tener mas control acerca de los datos y la distribucion que tienen
ggplot(ChickWeight, aes(Time, weight, col= Diet)) +
  geom_point() +
  stat_smooth(formula = y ~ x,
              method= "lm")

## leer datos desde rds. trabajaremos con los datos de temphum de la clase pasada. como estoy en un 
## proyecto de github, basta con llamarlo por su nombre
meteo <- read_rds("TempHum.rds") %>% 
  mutate(Mes = as.numeric(Mes))

sant <- meteo %>%
  filter(Ciudad_localidad == "Quinta Normal") 

ggplot(sant, aes(Mes, Temperatura))+
  geom_point()+
  geom_smooth(method = "lm", 
              col= "pink",
              fill= "light pink")

## dado que evidentemente la linea no ajusta, aplicaremos stat_smooth para seleccionar la forma de mis
## datos

ggplot(sant, aes(Mes, Temperatura))+
  geom_point(col= "light blue") +
  stat_smooth(method= "lm",
              formula= y ~ I(x^2)+x ,
              col= "pink",
              fill= "light pink")
sant2 <- meteo %>% 
  filter(Ciudad_localidad == "Quinta Normal") %>% 
  gather(key= Var_Amb,              ## nombre de la columna que quiero crear
         value = Valor,             ## valores asignados a la columna que estoy creando
         Temperatura, Humedad)      ## variables que yo quiero unir en la columna, en solo una variable

ggplot(sant2, aes(Mes, Valor, col= Var_Amb))+
  geom_point() +
  stat_smooth(method= "lm",
              formula= y ~ I(x^2)+x)

## dos ciudades
view(sant_pa)
sant_pa <- meteo %>% 
  filter(Ciudad_localidad %in% c("Quinta Normal", "Punta Arenas"))
ggplot(sant_pa, aes(Mes, Temperatura, col= Ciudad_localidad)) +
  geom_point() +
  stat_smooth(method= "lm",
              formula= y ~ I(x^2)+x)
## split en cuadros

City <- meteo %>% 
  filter(Ciudad_localidad %in% c("Quinta Normal", 
                                 "Punta Arenas",
                                 "La Serena",
                                 "Arica",
                                 "Vallenar"
                                 ))

ggplot(City, aes(Mes, Temperatura)) +
  geom_point() +
  stat_smooth(method= "lm",
              formula= y ~ I(x^2)+x) +
  facet_wrap(~ Ciudad_localidad, ncol= 2)

  