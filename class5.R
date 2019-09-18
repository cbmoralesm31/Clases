## Class 5: MODELOS

library(MuMIn)
library(broom)
library(ggplot2)
data("CO2")

## Antes de armar un modelo es util comenzar a armar ciertos graficos
ggplot(CO2, aes(x=conc, y=uptake)) + geom_point(aes(col= Treatment, shape= Type))+
         theme_classic()

ggplot(CO2, aes(x=conc, y=uptake, lty= Type)) + geom_point(aes(col= Treatment))+
  theme_classic() +
  geom_path(aes(group= Plant, color= Treatment))

## Modelo lineal simple

mls <- lm(uptake ~ conc + Treatment, data=CO2)
summary(mls)

## estas tres funciones del paquete broom me ayudan a sacar la info del modelo 
# glance() me da datos generales del modelo 
# tidy() me da los datos de los ajustes dentro del modelo
# augment() me da una tabla con un dato extra para cada punto 

sum1 <- glance(mls)
sum2 <- tidy(mls)
sum3 <- augment(mls)
View(sum3)
ggplot(sum3, aes(.fitted, .resid)) + geom_point() + 
         geom_hline( yintercept = 0, lty=2, color= "red")

## seleccion de modelos. AIC esta basado en criterios de informacion, que intenta darte la mayor informacion 
## posible con la menor cantidad de datos posibles. Cuanto mas bajo sea el AIC ese modelo tiene mayor P de ser
## elegido por nosotros. El valor de AIC no dice nada por si solo, si no que funciona cuando lo comparo con 
## otros modelos que estan siendo ajustados para los mismos datos. La idea es tener el minimo numero de K, 
## parametros. Cada parametro que tu as agregando se va penalizando. Likehood (L) 

## otros modelos
ml3 <- lm(uptake ~ Treatment, data=CO2)
ml2 <- lm(uptake ~ Plant, data=CO2)
ml1 <- lm(uptake ~ conc, data=CO2)
ml4 <- lm(uptake ~ Type, data= CO2)
ml5 <- lm(uptake ~ Treatment + conc)
ml6 <- lm(uptake ~ Treatment + Type, data= CO2)
ml7 <- lm(uptake ~ conc + Treatment + Type + Plant, data=CO2)
ml8 <- lm(uptake ~ conc + Treatment, data=CO2)
ml9 <- lm(uptake ~ conc + Treatment + Type, data=CO2)
ml10 <- lm(uptake ~ conc*Treatment*Type*Plant, data=CO2)
ml11 <- lm(uptake ~ conc + Type*Treatment, data=CO2)
glance(ml1)
glance(ml2)
glance(ml3)
glance(ml4)
glance(ml5)
glance(ml6)
glance(ml7)
glance(ml8)
glance(ml9)
glance(ml10)
glance(ml11)

## los datos no se modifican en la base de datos, sino dentro del modelo. Dado el primer grafico de previs
## se ve que la mejor transformacion es la logaritmica
ml12 <- lm(uptake ~ I(log(conc)) + Type*Treatment, data=CO2)
glance(ml12)

## agregar el efecto lineal 
ml13 <- lm(uptake ~ I(log(conc)) + conc + Type*Treatment, data=CO2)
glance(ml13)

## M$AIC[1]

## glm no tiene un r cuadrado por lo tanto explcarlo es un poco mas dificil
## ademas se ocupa para dist complejas. family cambia la estuctura de error
## kaggle 
## informe rmarkdown ojala con la base de datos pantheria, caracteres de animales xd!!, 
