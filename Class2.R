# clase investigacion reproducible
install.packages("tidyverse")
data("iris")
view(iris)
library("knitr")
DF <- iris %>% group_by(Species) %>% summarize_all(mean)
kable(DF, caption = "Promedio por especie de todas las variables de la base de datos iris.", 
      row.names = FALSE)