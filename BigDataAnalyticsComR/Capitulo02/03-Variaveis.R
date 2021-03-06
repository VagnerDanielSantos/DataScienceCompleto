
# Vari�veis em Linguagem R

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo02")
getwd()

# Cria vari�veis

var1 = 100
var1
mode(var1)
help("mode")
sqrt(var1)

# � poss�vel atribuir o valor de uma vari�vel a outra vari�vel

var2 = var1
var2
mode(var2)
typeof(var2)
help("typeof")

# Uma vari�vel pode ser uma lista de elementos

var3 = c("Primeiro", "Segundo", "Terceiro")
var3
mode(var3)

# Uma vari�vel pode ser uma fun��o

var4 = function(x) {x+3}
var4
mode(var4)

# � poss�vel tamb�m mudar o modo do Dado 

var5 = as.character(var1)
var5
mode(var5)

# Atribui valores a objetos

x <- c(1,2,3)
x
x1 = c(1,2,3)
x1
c(1,2,3) -> y
y
assign("x", c(6.3,4,-2))
x

# Verifica o valor em uma posi��o espec�fica

x[1]

# Verifica os objetos

ls()
objects()

# Remove objetos

rm(x)
x
