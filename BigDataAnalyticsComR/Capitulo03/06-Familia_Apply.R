
# Fam�lia Apply - Uma Forma Elegante de Fazer Loops

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo03")
getwd()

# Instala e Carrega pacotes

install.packages('sqldf')
library(sqldf)

#  apply() - Arrays e Matrizes
# tapply() - Os vetores podem ser divididos em diferentes subsets
# lapply() - Vetores e listas
# sapply() - Vers�o amig�vel da lapply
# vapply() - Similar a sapply, com valor de retorno modificado
# rapply() - Similar a lapply()
# eapply() - Gera uma lista
# mapply() - Similar a sapply, multivariada
# by

# Se estiver trabalhando com os objetos: 

# list, numeric, character (list/vecor) => sapply ou lapply
# matrix, data.frame (agrega��o por coluna) => by / tapply
# Opera��es por linha ou opera��es espec�ficas => apply

#### Loop

lista1 <- list(a = (1:20), b = (35:67))

# Calcula o total de cada elemento da lista com loop for

valor_a = 0
valor_b = 0

for (i in lista1$a){
  valor_a = valor_a + i 
}

for (j in lista1$b){
  valor_b = valor_b + j
}

print(valor_a)
print(valor_b)

# Calcula cada elemento da lista com sapply

?sapply
sapply(lista1, sum)

# Aplicando fun��es com sapply

sapply(lista1, mean)


# apply()

?apply

x <- matrix(c(20, 13, 65, 32, 45, 12, 76, 49, 82), nr = 3, byrow = T)
x

apply(x, mean)
apply(x, 1, mean)
apply(x, 2, mean)
apply(x, 1, plot)

resultapply <- apply(x, 1, mean)
resultapply

# Aplica apply() a um Dataframe

escola <- data.frame(Aluno = c('Bob', 'Tereza', 'Marta', 'Felipe', 'Zacarias', 'Elton'),
                     Fisica = c(91, 82, 75, 97, 62, 74),
                     Matematica = c(99, 100, 86, 92, 91, 87),
                     Quimica = c(56, 72, 49, 68, 59, 77))

print(escola)
escola$Matematica

# Calcula a m�dia por aluno

escola$Media = NA
escola

escola$Media = apply(escola[,c(2, 3, 4)], 1, mean)
escola
escola$Media = round(escola$Media)
escola


# tapply()

?gl

tabela_basquete <-
  data.frame(equipe = gl(5, 5, labels = paste("Equipe", LETTERS[1:5])),
             jogador = sample(letters, 25),
             num_cestas = floor(runif(25, min=0, max=50)))

View(tabela_basquete)
summary(tabela_basquete)

# Como calcular o total de cestas por Equipe ?

# tapply() vs sqldf

install.packages('sqldf')
library(sqldf)

sqldf("SELECT equipe, sum(num_cestas) FROM tabela_basquete GROUP BY equipe")

?tapply

tapply(tabela_basquete$num_cestas, tabela_basquete$equipe, sum)
tapply(tabela_basquete$num_cestas, tabela_basquete$equipe, mean)

# by

?by

dataframe <- data.frame(species=c(rep(c(1,2,3), each=5)), 
                  petal.length=c(rnorm(5, 4.5, 1), 
                                 rnorm(5, 4.5, 1), 
                                 rnorm(5, 5.5, 1)), 
                  petal.width=c(rnorm(5, 2.5, 1), 
                                rnorm(5, 2.5, 1), 
                                rnorm(5, 4, 1)))

dataframe$species <- factor(dataframe$species)
View(dataframe)

by(dataframe, dataframe$species, function(x){
  # calcular o comprimento m�dio da p�tala para cada esp�cie
  mean.pl <- mean(x$petal.length)
})


# lapply()

?lapply

lista01 <- list(a = (1:10), b = (45:77))
print(lista01)
lapply(lista01, sum)
sapply(lista01, sum)


# vapply()

?vapply

# A fun��o fivenum() retorna 5 estat�sticas do conjunto de dados: 
# (minimum, lower-hinge, median, upper-hinge, maximum) 
# https://stat.ethz.ch/R-manual/R-patched/library/stats/html/fivenum.html

vapply(lista01, 
       fivenum, 
       c(Min. = 0, 
         "1stQu." = 0, 
         Median = 0, 
         "3rd Qu." = 0, 
         Max = 0))


# replicate

?replicate

replicate(7, runif(10))


# mapply()

?mapply

mapply(rep, 1:4, 4:1)


# rapply()

?rapply

lista02 <- list(a = c(1:5), b = c(6:10))
print(lista02)

rapply(lista02, sum)
rapply(lista02, sum, how = "list")
