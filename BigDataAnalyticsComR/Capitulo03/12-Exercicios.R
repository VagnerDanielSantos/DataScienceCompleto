
# Lista de exercícios - Capítulo 03

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo03/Exercicios")
getwd()

# Exercício 01 - Pesquise pela função que permite listar todos os arquivo no diretório de trabalho

dir()
## OU ##
list.files()

# Exercício 02 - Crie um dataframe a partir de 3 vetores: um de caracteres, um lógico e um de números

caracter <- c("Python", "R", "D3js", "MongoDB", "Julia")
logico <- c(booleano = TRUE, TRUE, FALSE, TRUE, FALSE)
inteiro <- c(logico = 10, 50, 33, 99, 2)

dataframe01 <- data.frame(caracter, logico, inteiro)

print(dataframe01)

# Exercício 03 - Considere o vetor abaixo. 
# Crie um loop que verifique se há números maiores que 10 e imprima o número e uma mensagem no console.

vetor01 <- c(12, 3, 4, 19, 10, 34)
print(vetor01)

?length

for (numero in 1: length(vetor01)) 
{
  if(vetor01[numero] > 10)
  {
    print(vetor01[numero])
    print("Este número é maior que 10")
  }
  else if(vetor01[numero] == 10)
  {
    print(vetor01[numero])
    print("Este número é igual a 10")
  }
  else
  {
    print(vetor01[numero])
    print("Este número é menor que 10")
  }
}

# Exercício 04 - Conisdere a lista abaixo. 
# Crie um loop que imprima no console cada elemento da lista

lista01 <- list(2, 3, 5, 7, 11, 13)
print(lista01)

for (numero in 1: length(lista01) )
{
  print(lista01[[numero]])
}

# Exercício 05 - Considere as duas matrizes abaixo. 
# Faça uma multiplicação element-wise e multiplicação normal entre as materizes

matriz01 <- matrix(c(1:50), nrow = 5, ncol = 5, byrow = T)
print(matriz01)
matriz02 <- t(matriz01)
print(matriz02)

# Multiplicação element-wise

wise <- matriz01 * matriz02
print(wise)

# Multiplicação de matrizes

normal <- matriz01 %*% matriz02
print(normal)

# Exercício 06 - Crie um vetor, matriz, lista e dataframe e faça a nomeaççao de cada um dos objetos

vetor02 <- c(10, 05, 1990)
names(vetor02) <- c("Dia", "Mês", "Ano")

matriz03 <- matrix(c(10:18), nrow = 3, ncol = 3, byrow = TRUE)
dimnames(matriz03) <- (list(c("Linha01", "Linha02", "Linha03"), 
                            c("coluna01", "coluna02", "coluna03")))

lista02 <- list(c(10:20), c(4.7, 5.1, 10.1, 30.9, 77.7), c("Python", "R"))
names(lista02) <- c("Inteiros", "Floats", "Caracteres")

dataframe02 <- data.frame(c(10:14), 
                          c(4.7, 5.1, 10.1, 30.9, 77.7), 
                          c("Python", "R", "MongoDB", "C#", "Oracle"))

rownames(dataframe02) <- c("Obs01", "Obs02", "Obs03", "Obs04", "Obs05")
colnames(dataframe02) <- c("Inteiros", "Floats", "Caracteres")

# Exercício 07 - Considere a matriz abaixo. 
# Atribua valores 'NA' de forma aleatória para 50 elementos da matriz
# Dica: use a função sample()

?sample

matriz03 <- matrix(1:90, 10)
print(matriz03)

matriz03_na <- matriz03[sample(1:90, 50)] = NA
print(matriz03)

# Exercício 08 - Para a matriz abaixo, calcule a soma por linha e por coluna

matriz04 <- matrix(c(1:50), nrow = 5, ncol = 5, byrow = T)
print(matriz04)

soma_linha <- rowSums(matriz04)
print(soma_linha)
soma_coluna <- colSums(matriz04)
print(soma_coluna)

# Exercício 09 - Para o vetor abaixo, ordene os valores em ordem crescente

a <- c(100, 10, 10000, 1000)
print(a)

sort(a)
### OU
order(a)
a[order(a)]

# # Exercício 10 - Imprima no console todos os elementos da matriz abaixo que forem maiores que 15

matriz05 <- matrix(c(1:50), nrow = 5, ncol = 5, byrow = T)
print(matriz05)

for (numero in 1: length(matriz05))
{
  if(matriz05[numero] > 15)
  {
    print(matriz05[numero])
  }
}
