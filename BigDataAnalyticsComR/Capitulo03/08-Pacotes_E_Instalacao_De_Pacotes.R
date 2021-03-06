
# Pacotes e instala��o de Pacotes

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo03")
getwd()

# De onde vem as fun��es ? Pacotes (conjuntos de fun��es)
# Quando inicia o RStudio, alguns pacotes s�o carregados por padr�o

# Busca os pacotes carregados

search()

# Instala e carrega os pacotes

install.packages(c("ggvis", "tm", "dplyr"))
library(ggvis)
library(tm)
require(dplyr)

search()
?require
detach(package:dplyr)

# Lista o conte�do dos pacotes

?ls

ls(pos = "package:tm")
ls(getNamespace("tm"), all.names = TRUE)

# Lista as fun��es de um pacote

lsf.str("package:tm")
lsf.str("package:ggplot2")
library(ggplot2)
lsf.str("package:ggplot2")


# R possui um conjunto de datasets preinstalados. 

library(MASS)
data()

?lynx
head(lynx)
head(iris)
tail(lynx)
summary(lynx)

plot(lynx)
hist(lynx)
head(iris)
iris$Sepal.Length
sum(Sepal.Length)

?attach
attach(iris)
sum(Sepal.Length)
