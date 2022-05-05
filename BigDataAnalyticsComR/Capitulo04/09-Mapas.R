
# Mapas

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo04")
getwd()

# Instala os pacotes

install.packages(c("ggplot2", "maps", "mapdata"))

# Carrega os pacotes

library(ggplot2)
library(maps)
library(mapdata)

# Função para buscar as coordenadas dos países

?map_data

mapa <- map_data("world")

# Visualiza o dataframe

dim(mapa)
View(mapa)

# Gera o Mapa

ggplot() + geom_polygon(data = mapa, aes(x=long, y = lat, group = group)) + 
  coord_fixed(1.3)

ggplot() + 
  geom_polygon(data = mapa, aes(x=long, y = lat, group = group), fill = NA, color = "blue") + 
  coord_fixed(1.3)

gg1 <- ggplot() + 
  geom_polygon(data = mapa, aes(x=long, y = lat, group = group), fill = "seagreen1", color = "blue") + 
  coord_fixed(1.3)
gg1

# Marca alguns pontos no mapa
# É possível usar um shapefile

labs <- data.frame(
  long = c(69.24140, -2.8456051),
  lat = c(-78.38995, 22.44512),
  names = c("Ponto01", "Ponto02"),
  stringsAsFactors = FALSE
)  

# Pontos no mapa

gg1 + 
  geom_point(data = labs, aes(x = long, y = lat), color = "black", size = 2) +
  geom_point(data = labs, aes(x = long, y = lat), color = "yellow", size = 2)

# Divisão por países

ggplot(data = mapa) + 
  geom_polygon(aes(x = long, y = lat, fill = region, group = group), color = "white") + 
  coord_fixed(1.3) +
  guides(fill=FALSE)


# rMaps 
# http://rmaps.github.io
