
# Lista de exercícios -- Capítulo 02

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo02/Exercicios")
getwd()

#### Pacotes

install.packages("dplyr")
library(dplyr)

# Exercício 01 - Crie um vetor com 30 números inteiros

vetor <- c(30:60)
print(vetor)
class(vetor)

# Exercício 02 - Crie uma matriz com 4 linhas e 4 colunas preenchida com números inteiros

matriz <- matrix(1:16, nrow = 4, ncol = 4, by = TRUE)
print(matriz)

# Exercício 03 - Crie uma lista unindo o vetor e matriz criados anteriormente

lista <- list(vetor, matriz)
print(lista)

# Exercício 04 - Usando a função read.table(),
# leia o arquivo do link abaixo para uma dataframe: 
# http://data.princeton.edu/wws509/datasets/effort.dat

?read.table

arquivo <- read.table(file = "http://data.princeton.edu/wws509/datasets/effort.dat", 
                      header = TRUE, 
                      stringsAsFactors = FALSE, 
                      encoding = "UTF-8")
View(arquivo)

# Exercício 05 - Transforme o dataframe anterior
# em um dataframe nomeado com os seguintes labels:
# c("config", "esfc", "chang")

arquivo_nomeado <- arquivo

colnames(arquivo_nomeado) <- c("config", "esfc", "chang")
View(arquivo_nomeado)

# Exercício 06 - Imprima na tela o dataframe iris, 
#verifique quantas dimensões existem no dataframe iris e imprima um resumo do dataset

dataframe_iris <- iris
print(dataframe_iris)
dim(dataframe_iris)
str(dataframe_iris)
class(dataframe_iris)
summary(dataframe_iris)

# Exercício 07 - Crie um plot simples usando as duas primeiras colunas do dataframe iris

View(iris)

plot(x = iris$Sepal.Length, y = iris$Sepal.Width )

# Exercício 08 - Usando a função subset, crie um novo dataframe com o conjunto de dados 
# do dataframe iris em que Sepal.Length > 7
# Dica: consulte o help para aprender como usar a função subset()

?subset

iris_dataframe <- subset(iris, iris$Sepal.Length > 7 ) 
View(iris_dataframe)

# Exercício 09 (Desafio) - Crie um dataframe que seja cópia do dataframe iris e 
# usando a função slice(), divida o dataframe em um subset de 15 linhas
# Dica 1: Irá ter que instalar e carregar o pacote dplyr
# Dica 2: Consulte o help para aprender como usar a função slice()

install.packages("dplyr")
library(dplyr)

?slice

copia_iris <- iris
copia_iris %>%
  slice_sample(n = 15)

# Exercício 10 - Use a função filter no seu novo dataframe criado no item anterior e 
# retorne apenas valores em que Sepal.Length > 6
# Dica: Use o RSiteSearch para aprender como usar a função filter

copia_iris %>%
  filter(iris$Petal.Length > 6)
