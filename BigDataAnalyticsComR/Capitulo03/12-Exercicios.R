
# Lista de exerc�cios - Cap�tulo 03

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo03/Exercicios")
getwd()

# Exerc�cio 01 - Pesquise pela fun��o que permite listar todos os arquivo no diret�rio de trabalho

dir()
## OU ##
list.files()

# Exerc�cio 02 - Crie um dataframe a partir de 3 vetores: um de caracteres, um l�gico e um de n�meros

caracter <- c("Python", "R", "D3js", "MongoDB", "Julia")
logico <- c(booleano = TRUE, TRUE, FALSE, TRUE, FALSE)
inteiro <- c(logico = 10, 50, 33, 99, 2)

dataframe01 <- data.frame(caracter, logico, inteiro)

print(dataframe01)

# Exerc�cio 03 - Considere o vetor abaixo. 
# Crie um loop que verifique se h� n�meros maiores que 10 e imprima o n�mero e uma mensagem no console.

vetor01 <- c(12, 3, 4, 19, 10, 34)
print(vetor01)

?length

for (numero in 1: length(vetor01)) 
{
  if(vetor01[numero] > 10)
  {
    print(vetor01[numero])
    print("Este n�mero � maior que 10")
  }
  else if(vetor01[numero] == 10)
  {
    print(vetor01[numero])
    print("Este n�mero � igual a 10")
  }
  else
  {
    print(vetor01[numero])
    print("Este n�mero � menor que 10")
  }
}

# Exerc�cio 04 - Conisdere a lista abaixo. 
# Crie um loop que imprima no console cada elemento da lista

lista01 <- list(2, 3, 5, 7, 11, 13)
print(lista01)

for (numero in 1: length(lista01) )
{
  print(lista01[[numero]])
}

# Exerc�cio 05 - Considere as duas matrizes abaixo. 
# Fa�a uma multiplica��o element-wise e multiplica��o normal entre as materizes

matriz01 <- matrix(c(1:50), nrow = 5, ncol = 5, byrow = T)
print(matriz01)
matriz02 <- t(matriz01)
print(matriz02)

# Multiplica��o element-wise

wise <- matriz01 * matriz02
print(wise)

# Multiplica��o de matrizes

normal <- matriz01 %*% matriz02
print(normal)

# Exerc�cio 06 - Crie um vetor, matriz, lista e dataframe e fa�a a nomea��ao de cada um dos objetos

vetor02 <- c(10, 05, 1990)
names(vetor02) <- c("Dia", "M�s", "Ano")

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

# Exerc�cio 07 - Considere a matriz abaixo. 
# Atribua valores 'NA' de forma aleat�ria para 50 elementos da matriz
# Dica: use a fun��o sample()

?sample

matriz03 <- matrix(1:90, 10)
print(matriz03)

matriz03_na <- matriz03[sample(1:90, 50)] = NA
print(matriz03)

# Exerc�cio 08 - Para a matriz abaixo, calcule a soma por linha e por coluna

matriz04 <- matrix(c(1:50), nrow = 5, ncol = 5, byrow = T)
print(matriz04)

soma_linha <- rowSums(matriz04)
print(soma_linha)
soma_coluna <- colSums(matriz04)
print(soma_coluna)

# Exerc�cio 09 - Para o vetor abaixo, ordene os valores em ordem crescente

a <- c(100, 10, 10000, 1000)
print(a)

sort(a)
### OU
order(a)
a[order(a)]

# # Exerc�cio 10 - Imprima no console todos os elementos da matriz abaixo que forem maiores que 15

matriz05 <- matrix(c(1:50), nrow = 5, ncol = 5, byrow = T)
print(matriz05)

for (numero in 1: length(matriz05))
{
  if(matriz05[numero] > 15)
  {
    print(matriz05[numero])
  }
}
