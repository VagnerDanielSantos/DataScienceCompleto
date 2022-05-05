
# Gráfico de Pizza

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo04")
getwd()

?pie

# Cria as fatias

fatias = c(40, 20, 40)

# Nomeia os labels

paises = c("Uruguai", "Argentina", "Chile")

# Une paises e fatias

paises = paste(paises, fatias)

# Inclui mais detalhes no label

paises = paste(paises, "%", sep = "")

colors()

# Constrói um gráfico

pie(fatias, labels = paises,
    col = c("darksalmon", "gainsboro", "lemonchiffon4"), 
    main ="Distribuição de Vendas")


# Trabalha com Dataframes

?iris

attach(iris)
Values = table(Species) 
labels = paste(names(Values))
pie(Values, labels = labels, main = "Distribuições de espécies")


# 3D
install.packages("plotrix")
library(plotrix)

pie3D(fatias, labels = paises, explode = 0.05,
      col = c("steelblue1", "tomato2", "tan3"), 
      main = "Distribuição de Vendas")
