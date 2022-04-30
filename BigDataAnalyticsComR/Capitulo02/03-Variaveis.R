
# Variáveis em Linguagem R

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo02")
getwd()

# Cria variáveis

var1 = 100
var1
mode(var1)
help("mode")
sqrt(var1)

# É possível atribuir o valor de uma variável a outra variável

var2 = var1
var2
mode(var2)
typeof(var2)
help("typeof")

# Uma variável pode ser uma lista de elementos

var3 = c("Primeiro", "Segundo", "Terceiro")
var3
mode(var3)

# Uma variável pode ser uma função

var4 = function(x) {x+3}
var4
mode(var4)

# É possível também mudar o modo do Dado 

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

# Verifica o valor em uma posição específica

x[1]

# Verifica os objetos

ls()
objects()

# Remove objetos

rm(x)
x
