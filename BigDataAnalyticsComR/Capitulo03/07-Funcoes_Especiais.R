
# Fun��es Especiais

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo03")
getwd()

# Instala e Carrega pacotes

install.packages('plyr')
library(plyr)
install.packages("dplyr")
library(dplyr)
install.packages("tidyr")
library(tidyr)

# unlist()
# Produz um vetor com os elementos da lista

?unlist

lista01 <- list(6, "b", 15)
print(lista01)
class(lista01)

unlist(lista01)
vetor01 <- unlist(lista01)
class(vetor01)
print(vetor01)

lista02 <- list(v1 = 6, v2 = list(381, 2190), v3 = c(30, 217))
print(lista02)

unlist(lista02)

mean(unlist(lista02))
round(mean(unlist(lista02)))


# do.call()
# Executa uma fun��o em um objeto
# *** ATEN��O ***
# As fun��es da fam�lia apply aplicam uma fun��o a cada elemento de um objeto (substitui um loop)
# A fun��o do.call() aplica uma fun��o ao objeto inteiro e n�o a cada elemento individualmente

?do.call

data <- list()
N <- 100

for (n in 1:N) {
  data[[n]] = data.frame(index = n, char = sample(letters, 1), z = rnorm(1))
}

head(data)
View(data())

do.call(rbind, data)
class(do.call(rbind, data))

# lapply() x do.call()

y <- list(1:3, 4:6, 7:9)
y

lapply(y, sum)
do.call(sum, y)


# O resultado da fun��o lapply() pode ser obtido de outras formas
# Pacote plyr

install.packages('plyr')
library(plyr)

y <- list(1:3, 4:6, 7:9)
y

ldply(y, sum)


# strsplit()
# Divide uma string ou vetor de caracteres

texto01 <- "Data Science Academy"
strsplit(texto, " ")

texto02 <- "Data Science Academy"
strsplit(texto, "")


dates <- c("1998-05-23", "2008-12-30", "2009-11-29")
temp  <- strsplit(dates, "-")
temp
class(temp)

# Transforma a lista em matriz, fazendo antes um unlist()

matrix(unlist(temp), ncol = 3, byrow = TRUE)

Names <- c("Brin, Sergey", "Page, Larry",
           "Dorsey, Jack", "Glass, Noah",
            "Williams, Evan", "Stone, Biz")

temp <- strsplit(Names, ", ")
temp


frase <- "Muitas vezes temos que repetir algo diversas vezes e essas diversas vezes 
          parecem algo estranho"
palavras <- strsplit(frase, " ")[[1]]
palavras
unique(tolower(palavras))


# strplit() com Dataframes

antes = data.frame(attr = c(1,30,4,6), tipo = c('pao_e_agua','pao_e_agua_2'))
antes
strsplit(as.character(antes$tipo),'_e_')


library(stringr)

str_split_fixed(antes$tipo, "_e_", 2)


# Fun��o do.call()

antes = data.frame(attr = c(1,30,4,6), tipo = c('pao_e_agua','pao_e_agua_2'))
antes
depois <- strsplit(as.character(antes$tipo),'_e_')
depois
do.call(rbind, depois)

# Fun��es dplyr e tidyr

install.packages("dplyr")
install.packages("tidyr")
library(dplyr)
library(tidyr)

antes <- data.frame(
  attr = c(1, 30 ,4 ,6 ), 
  tipo = c('pao_e_agua','pao_e_agua_2')
)

antes %>%
  separate(tipo, c("pao", "agua"), "_e_")
