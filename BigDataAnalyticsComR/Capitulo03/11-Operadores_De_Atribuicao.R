
# Operadores de Atribui��o

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo03")
getwd()

vec1 = 1:4
vec2 <- 1:4

class(vec1)
class(vec2)

typeof(vec1)
typeof(vec2)


mean(x = 1:10)
x   

mean(x <- 1:10)
x 
