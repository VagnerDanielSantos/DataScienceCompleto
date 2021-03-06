
# Tipos avan�ados de Dados em linguagem R

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo02")
getwd()

#### Vetor: possui 1 dimens�o e 1 tipo de Dado

vetor01 <- c(1:20)
vetor01
length(vetor01)
mode(vetor01)
class(vetor01)
typeof(vetor01)

#### Matriz: possui 2 dimens�es e 1 tipo de Dado 

matriz01 <- matrix(1:20, nrow = 2)
matriz01
length(matriz01)
mode(matriz01)
class(matriz01)
typeof(matriz01)

#### Array: possui 2 ou mais dimens�es e 1 tipo de Dado 

array01 <- array(1:5, dim = c(3,3,3))
array01
length(array01)
mode(array01)
class(array01)
typeof(array01)

#### Data Frames: Dados de diferentes tipos
# Maneira mais f�cil de explicar data frames: � uma matriz com diferentes tipos de Dados

View(iris)
length(iris)
mode(iris)
class(iris)
typeof(iris)

#### Listas: Cole��o de diferentes objetos
# Diferentes tipos de Dados s�o poss�veis e comuns

lista01 <- list(a = matriz01, b = vetor01)
lista01
length(lista01)
mode(lista01)
class(lista01)
typeof(lista01)

# Fun��es tamb�m s�o vistas como objetos em linguagem R

funcao01 <- function(x) {
  var01 <- x * x
  return(var01)
}

funcao01(5)
class(funcao01)

# Remove objetos

objects()
rm(array01, funcao01)
objects()
